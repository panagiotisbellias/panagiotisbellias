#!/bin/bash
# create_multiple_repos.sh
# Usage: ./create_multiple_repos.sh supermodule_repos.txt
# supermodule_repos.txt format: repo-name|Description

REPOS_FILE=$1

if [ -z "$REPOS_FILE" ]; then
  echo "Usage: $0 repos.txt"
  exit 1
fi

while IFS="|" read -r repo desc; do
  # Skip empty lines or lines starting with #
  if [ -z "$repo" ] || [[ "$repo" =~ ^# ]]; then
    continue
  fi

  echo "Processing repository: $repo"

  # Check if repo exists (in your account/organization)
  if gh repo view "$repo" &>/dev/null; then
    echo "⚠️ Repository '$repo' already exists, skipping..."
  else
    echo "✅ Creating private repository: $repo"
	# Clean description
	clean_desc=$(echo "$desc" | tr -d '[:cntrl:]' | xargs)
    gh repo create "$repo" --private --description "$clean_desc" -y
  fi

done < "$REPOS_FILE"
