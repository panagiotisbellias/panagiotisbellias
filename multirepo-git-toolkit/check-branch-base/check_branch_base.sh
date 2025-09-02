#!/bin/bash
# Usage: ./check_branch_base.sh TARGET_BRANCH [OUTPUT_FILE] [START_DIR] [SKIP_REPOS_FILE]
# Example: ./check_branch_base.sh development check_branch_base.log . skip_repos.txt

TARGET_BRANCH=${1:?Usage: $0 TARGET_BRANCH [OUTPUT_FILE] [START_DIR] [SKIP_REPOS_FILE]}
OUTPUT_FILE=${2:-check_branch_base.log}
START_DIR=${3:-.}
SKIP_REPOS_FILE=${4:-}

> "$OUTPUT_FILE"

echo "📝 Checking if branch '$TARGET_BRANCH' is based on main/master in all repos under $START_DIR"
echo "Output file: $OUTPUT_FILE"
[ -n "$SKIP_REPOS_FILE" ] && echo "Skipping repos listed in: $SKIP_REPOS_FILE"
echo "---------------------------------------"

find "$START_DIR" -name ".git" \( -type d -o -type f \) \
  | { if [ -n "$SKIP_REPOS_FILE" ]; then grep -vFf "$SKIP_REPOS_FILE"; else cat; fi; } \
  | while IFS= read -r git_entry; do
    repo_dir=$(dirname "$git_entry")
    repo_name=$(basename "$repo_dir")
    echo "📂 Processing $repo_dir ..."
    {
        echo "=============================================="
        echo "📂 Repository: $repo_dir"
        echo "📅 Timestamp : $(date)"
        echo "----------------------------------------------"

        # Skip repos in skip list
        if [ -n "$SKIP_REPOS_FILE" ] && grep -qx "$repo_name" "$SKIP_REPOS_FILE"; then
            echo "⏭️ Skipping repo '$repo_name' (in skip list)"
            echo
            continue
        fi

        cd "$repo_dir" || { echo "⚠️ Failed to enter $repo_dir"; continue; }

        # Detect main or master in origin
        main_branch=""
        if git ls-remote --heads origin main | grep -q main; then
            main_branch="main"
        elif git ls-remote --heads origin master | grep -q master; then
            main_branch="master"
        fi

        if [ -z "$main_branch" ]; then
            echo "⚠️ No main or master branch found on origin"
            
            # Create main branch from first commit if missing
            first_commit=$(git rev-list --max-parents=0 HEAD | head -n 1)
            if [ -n "$first_commit" ]; then
                echo "🌱 Creating 'main' branch from first commit ($first_commit)"
                # Unset any stale upstream if it exists
                git branch --unset-upstream main 2>/dev/null || true
                git checkout -B main "$first_commit"
                git push -u origin main
                main_branch="main"
                echo "✅ Pushed 'main' branch to origin"
            else
                echo "❌ Could not determine initial commit"
                cd - >/dev/null
                continue
            fi
        else
            echo "✅ Found origin/$main_branch"

            # Check if target branch exists locally or remotely
            if git show-ref --verify --quiet "refs/heads/$TARGET_BRANCH"; then
                branch_commit=$(git rev-parse "$TARGET_BRANCH")
            elif git ls-remote --heads origin "$TARGET_BRANCH" | grep -q "$TARGET_BRANCH"; then
                branch_commit=$(git rev-parse "origin/$TARGET_BRANCH")
            else
                echo "⚠️ Branch '$TARGET_BRANCH' does not exist"
                cd - >/dev/null
                continue
            fi

            # Compare ancestry
            base_commit=$(git merge-base "$TARGET_BRANCH" "origin/$main_branch" 2>/dev/null || true)
            if [ -z "$base_commit" ]; then
                echo "❌ Cannot determine base commit for $TARGET_BRANCH vs $main_branch"
            else
                if git merge-base --is-ancestor "$base_commit" "$TARGET_BRANCH"; then
                    echo "✅ Branch '$TARGET_BRANCH' is based on origin/$main_branch"
                else
                    echo "⚠️ Branch '$TARGET_BRANCH' exists but is NOT based on origin/$main_branch"
                fi
            fi
        fi

        # Switch back to target branch if it exists
        if git show-ref --verify --quiet "refs/heads/$TARGET_BRANCH"; then
            git checkout "$TARGET_BRANCH"
            echo "↩️ Switched back to branch '$TARGET_BRANCH'"
        fi
        cd - >/dev/null
        echo

    } | tee -a "$OUTPUT_FILE"

done < <(find "$START_DIR" -name ".git" \( -type d -o -type f \) )
