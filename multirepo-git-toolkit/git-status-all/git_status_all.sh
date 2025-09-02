#!/bin/bash
# Usage: ./git_status_all.sh [OUTPUT_FILE]
# Default output file: git-status.log

OUTPUT_FILE=${1:-git-status.log}
> "$OUTPUT_FILE"   # clear previous log

echo "📝 Collecting git status for all repos (including submodules)..." 
echo "Output will be written to $OUTPUT_FILE"
echo "---------------------------------------"

dirty_repos=()
total_repos=0

# Find all git repos: .git directory OR .git file (for submodules)
while IFS= read -r git_entry; do
    repo=$(dirname "$git_entry")
    total_repos=$((total_repos + 1))
    echo "📂 Checking $repo ..."
    {
        echo "=============================================="
        echo "📂 Repository: $repo"
        echo "📅 Timestamp : $(date)"
        echo "----------------------------------------------"
        (
            cd "$repo" || { echo "⚠️ Failed to enter $repo"; exit 1; }

            # Porcelain with submodule changes included
            status=$(git status --porcelain=2 --untracked-files=all --ignore-submodules=none)

            git status --ignore-submodules=none
            echo

            # Repo is dirty if porcelain has content
            if [ -n "$status" ]; then
                echo "⚠️ Repo is DIRTY: $repo" >&2
                dirty_repos+=("$repo")
            fi
        )
    } | tee -a "$OUTPUT_FILE"
done < <(find . -name ".git" \( -type d -o -type f \))
