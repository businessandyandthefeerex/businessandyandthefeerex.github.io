#!/usr/bin/env bash

# Create and open a new review draft. This script is safe to run from a file manager.
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || realpath "${BASH_SOURCE[0]}" 2>/dev/null || printf '%s' "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

REPO_DIR=""
SEARCH_DIR="$SCRIPT_DIR"
while [[ "$SEARCH_DIR" != / ]]; do
  if [[ -d "$SEARCH_DIR/src/posts" ]]; then
    REPO_DIR="$SEARCH_DIR"
    break
  fi
  SEARCH_DIR="$(dirname "$SEARCH_DIR")"
done

if [[ -z "$REPO_DIR" ]]; then
  printf 'Could not find the repository containing the src/posts folder from: %s\n' "$SCRIPT_DIR" >&2
  exit 1
fi
POSTS_DIR="$REPO_DIR/src/posts"

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
dishes:
  -
---

<!-- BEFORE PUBLISHING THIS REVIEW

1. Fill in the front matter above:
   - title: restaurant name
   - rating: 1-4
   - meal: usually breakfast, lunch or dinner
   - region, city, suburb and address: restaurant location details
   - website: restaurant website, or leave blank if unavailable

2. Add the dishes eaten, one per line. Start each dish with two spaces, a dash, and a space; the first one is already started for you. For example:
     - Fish and chips
     - Roast chicken

   Put quote marks around a dish if it contains the characters ": " or starts with a special character such as - or ?. For example:
     - "Chef's special: fish"
   A dash inside a normal dish does not need quotes, for example "Fish - chips".

3. To link to a previous review, use this format:
   [Restaurant name](/posts/yyyy-mm-dd-restaurant-name/)

4. Write the review below this instruction block.

5. Delete this instruction block when the review is ready.
-->

EOF

sed -i "s/PLACEHOLDER_DATE/$DATE/" "$POSTS_DIR/$POST_NAME"

if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$POSTS_DIR/$POST_NAME"
elif command -v open >/dev/null 2>&1; then
  open "$POSTS_DIR/$POST_NAME"
fi
