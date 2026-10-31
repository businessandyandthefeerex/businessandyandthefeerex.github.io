#!/usr/bin/env bash

# Create and open a new review draft. This script is safe to run from a file manager.
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || realpath "${BASH_SOURCE[0]}" 2>/dev/null || printf '%s' "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

REPO_DIR=""
SEARCH_DIR="$SCRIPT_DIR"
while [[ "$SEARCH_DIR" != / ]]; do
  if [[ -d "$SEARCH_DIR/_posts" ]]; then
    REPO_DIR="$SEARCH_DIR"
    break
  fi
  SEARCH_DIR="$(dirname "$SEARCH_DIR")"
done

if [[ -z "$REPO_DIR" ]]; then
  printf 'Could not find the repository containing the _posts folder from: %s\n' "$SCRIPT_DIR" >&2
  exit 1
fi
POSTS_DIR="$REPO_DIR/_posts"

if [[ ! -d "$POSTS_DIR" ]]; then
  printf 'Could not find the posts folder: %s\n' "$POSTS_DIR" >&2
  exit 1
fi
DATE="$(date +%Y-%m-%d)"

mkdir -p "$POSTS_DIR"

POST_NAME="$DATE-new-review.md"
COUNTER=2
while [[ -e "$POSTS_DIR/$POST_NAME" ]]; do
  POST_NAME="$DATE-new-review-$COUNTER.md"
  ((COUNTER++))
done

cat > "$POSTS_DIR/$POST_NAME" <<'EOF'
---
category: Reviews
layout: post
title:
date: PLACEHOLDER_DATE
rating:
meal:
country: New Zealand
region:
city:
suburb:
address:
website:
---

EOF

sed -i "s/PLACEHOLDER_DATE/$DATE/" "$POSTS_DIR/$POST_NAME"

if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$POSTS_DIR/$POST_NAME"
elif command -v open >/dev/null 2>&1; then
  open "$POSTS_DIR/$POST_NAME"
fi
