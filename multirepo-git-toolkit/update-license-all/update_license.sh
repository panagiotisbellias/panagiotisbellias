#!/usr/bin/env bash

# === Config ===
USER="panagiotisbellias"
BRANCH="development"  # or main

# Apache 2.0 License text
LICENSE_TEXT="                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

Copyright (c) $(date +%Y) $USER

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License."

# === Function to update LICENSE in one repo ===
update_repo_license() {
    local repo_path="$1"
    cd "$repo_path" || return

    if [ ! -d ".git" ]; then
        echo "⚠️  Skipping $repo_path (not a git repo)"
        return
    fi

    echo "📦 Updating LICENSE in $repo_path"

    # Write LICENSE
    echo "$LICENSE_TEXT" > LICENSE

    # Ensure branch exists
    git checkout "$BRANCH" 2>/dev/null || git checkout -b "$BRANCH"

    # Check if LICENSE changed
    if ! git diff --quiet LICENSE; then
        git add LICENSE
        git commit -m "Add/Update LICENSE to Apache 2.0"

        # Push with gh
        repo_name=$(basename "$(git rev-parse --show-toplevel)")
        gh repo set-default "${USER}/${repo_name}" 2>/dev/null
        git push origin "$BRANCH"

        echo "✅ LICENSE updated and pushed in $repo_path"
    else
        echo "⚠️  No changes in LICENSE for $repo_path"
    fi
}

# === Function to update LICENSE in submodules recursively ===
update_submodules() {
    echo "🔍 Updating submodules for $(pwd)"
    git submodule update --init --recursive
    git submodule foreach --recursive '
        echo "➡️ Entering $sm_path"
        bash -c "update_repo_license \"$(pwd)\"" || true
    '
}

# === Main loop over directories ===
PARENT_DIR="${1:-$PWD}"  # pass as argument or use current dir

find "$PARENT_DIR" -type d -name ".git" | while read -r gitdir; do
    repo_dir=$(dirname "$gitdir")
    update_repo_license "$repo_dir"
    (cd "$repo_dir" && update_submodules)
done
