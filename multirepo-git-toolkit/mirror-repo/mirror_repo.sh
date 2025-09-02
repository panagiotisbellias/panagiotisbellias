#!/bin/bash
# Usage: ./mirror_repo.sh SOURCE_URL [TARGET_REPO] [CHECKOUT_BRANCH] [OUTPUT_FILE]
# Example: ./mirror_repo.sh https://github.com/someuser/somelib.git myforkedlib development mirror.log

SOURCE_URL=$1
TARGET_REPO=$2
CHECKOUT_BRANCH=$3
OUTPUT_FILE=${4:-mirror.log}

if [ -z "$SOURCE_URL" ]; then
  echo "Usage: $0 SOURCE_URL [TARGET_REPO] [CHECKOUT_BRANCH] [OUTPUT_FILE]"
  exit 1
fi

# Clear log
> "$OUTPUT_FILE"

# Helper for logging
log() {
  echo -e "$@" | tee -a "$OUTPUT_FILE"
}

# Extract repo name if not provided
if [ -z "$TARGET_REPO" ]; then
  TARGET_REPO=$(basename -s .git "$SOURCE_URL")
fi

# Get GitHub username
TARGET_USER=$(gh api user --jq .login)

LOCAL_DIR=$TARGET_REPO

log "=============================================="
log "🔍 Source: $SOURCE_URL"
log "🎯 Target: $TARGET_USER/$TARGET_REPO"
log "📂 Local : $LOCAL_DIR"
log "📝 Log   : $OUTPUT_FILE"
log "📅 Time  : $(date)"
log "----------------------------------------------"

# Clone if missing
if [ ! -d "$LOCAL_DIR/.git" ]; then
  log "⬇️ Cloning $SOURCE_URL ..."
  git clone --mirror "$SOURCE_URL" "$LOCAL_DIR" 2>&1 | tee -a "$OUTPUT_FILE"
else
  log "📂 Repo $LOCAL_DIR already exists locally, fetching latest..."
  (
    cd "$LOCAL_DIR" || exit 1
    git fetch --all 2>&1 | tee -a "../$OUTPUT_FILE"
  )
fi

# Ensure GitHub repo exists
if ! gh repo view "$TARGET_USER/$TARGET_REPO" >/dev/null 2>&1; then
  log "✨ Creating new public repo $TARGET_USER/$TARGET_REPO ..."
  gh repo create "$TARGET_USER/$TARGET_REPO" --public --confirm | tee -a "$OUTPUT_FILE"
else
  log "✅ Repo $TARGET_USER/$TARGET_REPO already exists"
fi

cd "$LOCAL_DIR" || exit 1

TARGET_URL="git@github.com:$TARGET_USER/$TARGET_REPO.git"

log "🔗 Setting remote URL to $TARGET_URL ..."
git remote remove origin 2>/dev/null || true
git remote add origin "$TARGET_URL"

# Push all refs
log "🚀 Pushing repo to $TARGET_USER/$TARGET_REPO ..."
git push --mirror origin 2>&1 | tee -a "../$OUTPUT_FILE"

# Branch checkout if given
if [ -n "$CHECKOUT_BRANCH" ]; then
  log "🔎 Preparing to checkout branch '$CHECKOUT_BRANCH'..."

  git fetch origin 2>&1 | tee -a "../$OUTPUT_FILE"

  if git show-ref --verify --quiet "refs/heads/$CHECKOUT_BRANCH"; then
    log "   ✅ Branch '$CHECKOUT_BRANCH' exists locally, checking out..."
    git checkout "$CHECKOUT_BRANCH" 2>&1 | tee -a "../$OUTPUT_FILE"
  elif git ls-remote --exit-code --heads origin "$CHECKOUT_BRANCH" >/dev/null 2>&1; then
    log "   🔄 Branch '$CHECKOUT_BRANCH' exists on remote, checking out..."
    git checkout -b "$CHECKOUT_BRANCH" --track "origin/$CHECKOUT_BRANCH" 2>&1 | tee -a "../$OUTPUT_FILE"
  else
    log "   ⚠️ Branch '$CHECKOUT_BRANCH' does not exist, creating from base branch..."

    BASE_BRANCH=""
    if git ls-remote --exit-code --heads origin main >/dev/null 2>&1; then
      BASE_BRANCH="origin/main"
    elif git ls-remote --exit-code --heads origin master >/dev/null 2>&1; then
      BASE_BRANCH="origin/master"
    else
      BASE_BRANCH=$(git rev-list --max-parents=0 HEAD | head -n 1)
      log "   🌱 No main/master found, using first commit ($BASE_BRANCH)"
    fi

    git checkout -b "$CHECKOUT_BRANCH" "$BASE_BRANCH" 2>&1 | tee -a "../$OUTPUT_FILE"
    git push -u origin "$CHECKOUT_BRANCH" 2>&1 | tee -a "../$OUTPUT_FILE"
    log "   ✅ Created branch '$CHECKOUT_BRANCH' from $BASE_BRANCH"
  fi
fi

cd ..

log "✅ Repo successfully mirrored to https://github.com/$TARGET_USER/$TARGET_REPO"
if [ -n "$CHECKOUT_BRANCH" ]; then
  log "✅ Checked out branch: $CHECKOUT_BRANCH"
fi
