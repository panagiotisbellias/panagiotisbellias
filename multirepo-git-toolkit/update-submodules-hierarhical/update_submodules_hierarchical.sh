#!/bin/bash
# Usage: ./update_submodules_hierarchical.sh USER BRANCH submodules.txt
# USER   = GitHub username or org
# BRANCH = branch in which to commit submodules (will create if missing)

USER=$1
BRANCH=$2
FILE=$3

set -e  # exit on errors
trap 'echo -e "\n❌ Script failed on line $LINENO. Press Enter to exit..."; read' ERR

if [ -z "$USER" ] || [ -z "$BRANCH" ] || [ -z "$FILE" ]; then
  echo "Usage: $0 USER BRANCH submodules.txt"
  exit 1
fi

echo "🔧 Starting script with:"
echo "   USER   = $USER"
echo "   BRANCH = $BRANCH"
echo "   FILE   = $FILE"

current_parent=""

# Preprocess file: strip CR, trim whitespace, drop blanks and comments
mapfile -t lines < <(sed 's/\r//g' "$FILE" | sed 's/^[ \t]*//;s/[ \t]*$//' | grep -v '^$')

total=${#lines[@]}
count=0

for line in "${lines[@]}"; do
  ((count++)) || echo
  echo "---------------------------------------------"
  echo "📜 [$count/$total] Processing line: '$line'"

  # Handle parent markers [repo-name]
  if [[ "$line" =~ ^\[(.*)\]$ ]]; then
    current_parent="${BASH_REMATCH[1]}"
    echo "📂 Found parent repo: '$current_parent' ($count/$total)"
	  
    # remove any leftover control chars or spaces
    current_parent=$(echo "$current_parent" | tr -d '[:space:][:cntrl:]')
    safe_parent=$(echo "$current_parent" | tr -d '[]?<>:"/\\|*')

    echo "🔍 Cleaned parent repo: '$current_parent'"
    echo "   Safe folder name:    '$safe_parent'"

    echo "➡️  Cloning https://github.com/$USER/$safe_parent.git into folder $safe_parent"
    if [ ! -d "$safe_parent" ]; then
        echo "📥 Running: gh repo clone \"https://github.com/$USER/$safe_parent.git\" \"$safe_parent\""
        gh repo clone "https://github.com/$USER/$safe_parent.git" "$safe_parent"
        clone_status=$?
        echo "   Clone exit code: $clone_status"
    else
        echo "⚠️  Folder $safe_parent already exists, skipping clone."
    fi

    cd "$safe_parent" || { echo "❌ Failed to cd into $safe_parent"; }

    echo "🔀 Checking if branch '$BRANCH' exists locally..."
    # Detect if repo is empty (no commits yet)
    if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
      echo "🆕 Repository is empty, creating initial commit..."
      if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
        echo "📡 Remote already has branch '$BRANCH', checking it out..."
        git fetch origin "$BRANCH"
        git checkout -b "$BRANCH" "origin/$BRANCH"
      else
        echo "🆕 Creating orphan branch '$BRANCH' with initial commit..."
        git checkout --orphan "$BRANCH"
        echo "# $safe_parent" > README.md
        git add README.md
        git commit -m "Initial commit"
        git push -u origin "$BRANCH"
      fi
    else
      if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
          echo "✅ Branch '$BRANCH' exists locally, checking out."
          git checkout "$BRANCH"
      else
          echo "❌ Branch '$BRANCH' not found locally."
          echo "🔎 Checking if it exists on remote..."
          if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
              echo "🌍 Branch '$BRANCH' exists on origin, creating local tracking branch."
              git checkout -b "$BRANCH" "origin/$BRANCH"
          else
              echo "🆕 Creating new branch '$BRANCH' and pushing to origin."
              git checkout -b "$BRANCH"
              git push -u origin "$BRANCH"
          fi
      fi
    fi

    cd - >/dev/null || exit
    continue
  fi

  # Skip if not a valid GitHub repo name
  #    - only allow alphanumeric, dash, underscore, dot
  if [[ ! "$line" =~ ^[A-Za-z0-9._-]+$ ]]; then
    echo "⚠️  [$count/$total] Skipping invalid repo name: '$line'"
    continue
  fi

  # Otherwise it's a submodule repo
  submodule_repo="$line"
  url="https://github.com/$USER/$submodule_repo.git"
  path=$(echo "$submodule_repo" | tr -d '[:space:][:cntrl:][]?<>:"/\\|*')  # sanitize submodule folder

  echo "✅ [$count/$total] Adding submodule $submodule_repo"
  echo "   URL:       $url"
  echo "   Path:      $safe_parent/$path"

  cd "$safe_parent" || { echo "❌ Failed to cd into $safe_parent"; }

  echo "🔀 Ensuring we are on branch '$BRANCH'..."
  git checkout "$BRANCH"

  if [ ! -d "$path" ]; then
    echo "📥 Running: git submodule add \"$url\" \"$path\""
    git submodule add "$url" "$path"
    add_status=$?
    echo "   Submodule add exit code: $add_status"
  fi

  # Enter the submodule repo
  cd "$path" || { echo "❌ Failed to cd into submodule $path"; }

  echo "🔀 Ensuring branch '$BRANCH' exists in submodule..."
  # Detect if repo is empty (no commits yet)
  if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "🆕 Repository is empty, creating initial commit..."
    if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
        echo "📡 Remote already has branch '$BRANCH', checking it out..."
        git fetch origin "$BRANCH"
        git checkout -b "$BRANCH" "origin/$BRANCH"
    else
        echo "🆕 Creating orphan branch '$BRANCH' with initial commit..."
        git checkout --orphan "$BRANCH"
        echo "# $safe_parent" > README.md
        git add README.md
        git commit -m "Initial commit"
        git push -u origin "$BRANCH"
    fi
  else
    echo "🔀 Checking if branch '$BRANCH' exists locally..."
    if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        git checkout "$BRANCH"
    else
        if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
            git checkout -b "$BRANCH" "origin/$BRANCH"
        else
            git checkout -b "$BRANCH"
            git push -u origin "$BRANCH" || echo "Possibly archived repo, didn't push"
        fi
    fi
  fi

  echo "⬇️  Pulling latest changes in submodule $submodule_repo..."
  git pull origin "$BRANCH" || echo "⚠️  Pull failed, continuing"

  sub_commit=$(git rev-parse HEAD)
  cd ..   # back to parent

  echo "💾 Updating parent to new submodule commit $sub_commit..."
  git add $submodule_repo || git add .
  git commit -m "Update submodule $submodule_repo to $sub_commit" || echo "No update needed"

  echo "🚀 Pushing parent changes..."
  if ! git push -u origin "$BRANCH" --no-verify; then
    echo "⚠️  Push failed (likely remote is ahead). Skipping to avoid fast-forward."
  fi

  cd .. >/dev/null || echo "Failed to change directory"

done

echo "🎉 Script finished."
