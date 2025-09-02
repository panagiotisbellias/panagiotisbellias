#!/bin/bash
# Usage: ./checkout_branch_all.sh PARENT_DIR BRANCH [OUTPUT_FILE] [SKIP_REPOS_FILE]
# Example: ./checkout_branch_all.sh ~/Projects/Personal development checkout_branch_all.log skip.txt
#
# skip.txt should contain one repo name or path fragment per line

PARENT_DIR=$1
BRANCH=$2
OUTPUT_FILE=${3:-checkout_branch_all.log}
SKIP_REPOS_FILE=$4

if [ -z "$PARENT_DIR" ] || [ -z "$BRANCH" ]; then
  echo "Usage: $0 PARENT_DIR BRANCH [OUTPUT_FILE] [SKIP_REPOS_FILE]"
  exit 1
fi

> "$OUTPUT_FILE"

echo "📝 Checking out branch '$BRANCH' in repos under $PARENT_DIR (including submodules)"
[ -n "$SKIP_REPOS_FILE" ] && echo "⏭️ Using skip list from: $SKIP_REPOS_FILE"
echo "Output file: $OUTPUT_FILE"
echo "---------------------------------------"

process_repo() {
  local repo_dir=$1

  {
    echo "=============================================="
    echo "➡️ Processing repo: $repo_dir"
    echo "📅 Timestamp : $(date)"
    echo "----------------------------------------------"

    cd "$repo_dir" || { echo "⚠️ Failed to enter $repo_dir"; return; }

    # Fetch latest refs
    git fetch origin

    current_branch=$(git rev-parse --abbrev-ref HEAD)

    if [ "$current_branch" == "$BRANCH" ]; then
      echo "   ✅ Already on $BRANCH, pulling latest..."
      git pull
    else
      # Check if branch exists on remote
      if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
        echo "   🔄 Switching to existing remote branch $BRANCH"
        git stash push -u
        git checkout "$BRANCH"
        git pull
        git stash pop
      else
        echo "   ✨ Creating new local branch $BRANCH (no push)"
        git checkout -b "$BRANCH"
        # 🚫 No push — stays local only
      fi
    fi

    # 🔍 Process submodules (if any)
    if [ -f .gitmodules ]; then
      echo "   📦 Found submodules, processing..."
      git submodule update --init --recursive
      git submodule foreach "
        echo \"      ➡️ Processing submodule: \$sm_path\";
        git fetch origin;
        if git rev-parse --abbrev-ref HEAD | grep -q \"$BRANCH\"; then
          echo \"         ✅ Already on $BRANCH, pulling latest...\";
          git pull;
        elif git ls-remote --heads origin \"$BRANCH\" | grep -q \"$BRANCH\"; then
          echo \"         🔄 Switching to existing remote branch $BRANCH\";
          git checkout \"$BRANCH\";
          git pull;
        else
          echo \"         ✨ Creating new local branch $BRANCH (no push)\";
          git checkout -b \"$BRANCH\";
        fi"
    fi

    cd - >/dev/null || exit
    echo

  } | tee -a "$OUTPUT_FILE"
}

# Build find command with optional skip filter
if [ -n "$SKIP_REPOS_FILE" ]; then
  find "$PARENT_DIR" -type d -name ".git" \
    | grep -vFf "$SKIP_REPOS_FILE" \
    | while read -r gitdir; do
        repo_dir=$(dirname "$gitdir")
        process_repo "$repo_dir"
      done
else
  find "$PARENT_DIR" -type d -name ".git" \
    | while read -r gitdir; do
        repo_dir=$(dirname "$gitdir")
        process_repo "$repo_dir"
      done
fi
