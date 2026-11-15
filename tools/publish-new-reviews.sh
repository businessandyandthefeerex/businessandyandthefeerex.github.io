#!/usr/bin/env bash

# Validate, commit and push new or changed reviews in src/posts.
# Safe to run from a file manager or a terminal.

in_terminal() {
  [[ -t 0 && -t 1 ]]
}

fail() {
  local message="${1:-Publishing failed}"
  printf '%s\n' "$message" >&2

  if ! in_terminal; then
    if command -v kdialog >/dev/null 2>&1; then
      kdialog --error "$message" --title "Publish review" >/dev/null 2>&1
    elif command -v zenity >/dev/null 2>&1; then
      zenity --error --title="Publish review" --text="$message" >/dev/null 2>&1
    fi
  fi
  exit 1
}

notify() {
  local message="$1"
  if ! in_terminal && command -v kdialog >/dev/null 2>&1; then
    kdialog --msgbox "$message" --title "Publish review" >/dev/null 2>&1
  elif ! in_terminal && command -v zenity >/dev/null 2>&1; then
    zenity --info --title="Publish review" --text="$message" >/dev/null 2>&1
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send "Publish review" "$message" >/dev/null 2>&1
  fi
}

# Asks whether to carry on. Succeeds if the answer is yes. When there is no
# terminal and no dialog tool to ask with, it carries on, since the warnings
# have already been printed.
confirm() {
  local message="$1"
  printf '%s\n' "$message" >&2

  if in_terminal; then
    local answer
    read -r -p "Publish anyway? [y/N] " answer
    [[ "$answer" =~ ^[Yy] ]]
  elif command -v kdialog >/dev/null 2>&1; then
    kdialog --warningyesno "$message"$'\n\nPublish anyway?' --title "Publish review" >/dev/null 2>&1
  elif command -v zenity >/dev/null 2>&1; then
    zenity --question --title="Publish review" --text="$message"$'\n\nPublish anyway?' >/dev/null 2>&1
  else
    return 0
  fi
}

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
  fail "Could not find the repository containing the src/posts folder from: $SCRIPT_DIR"
fi

cd "$REPO_DIR" || fail "Could not open the repository: $REPO_DIR"

VALIDATOR="$REPO_DIR/tools/validate-review.js"
[[ -f "$VALIDATOR" ]] || fail "Could not find the review checker: $VALIDATOR"
command -v node >/dev/null 2>&1 || fail "Node.js was not found, so the review can't be checked. If Node comes from nvm, a script launched from a file manager may not see it; try running this from a terminal."

POST_FILES=()
if [[ $# -gt 0 ]]; then
  for POST_FILE in "$@"; do
    [[ "$POST_FILE" = /* ]] || POST_FILE="$REPO_DIR/$POST_FILE"
    POST_FILES+=("$POST_FILE")
  done
else
  # Edited, staged and brand new posts. Deleted posts are left out.
  while IFS= read -r POST_FILE; do
    [[ -n "$POST_FILE" ]] && POST_FILES+=("$REPO_DIR/$POST_FILE")
  done < <({
    git diff --name-only --diff-filter=d -- src/posts
    git diff --cached --name-only --diff-filter=d -- src/posts
    git ls-files --others --exclude-standard -- src/posts
  } | sort -u)
fi

if [[ ${#POST_FILES[@]} -eq 0 ]]; then
  fail "No changed review files found in src/posts."
fi

# The checker prints one tab-separated line per result: OK, WARN or ERROR,
# then the file name, then the title or message.
VALIDATION_OUTPUT="$(node "$VALIDATOR" "${POST_FILES[@]}" 2>&1)"
VALIDATION_STATUS=$?

TITLES=()
ERRORS=()
WARNINGS=()
while IFS=$'\t' read -r KIND FILE_NAME MESSAGE; do
  case "$KIND" in
    OK)    TITLES+=("$MESSAGE") ;;
    ERROR) ERRORS+=("$FILE_NAME: $MESSAGE") ;;
    WARN)  WARNINGS+=("$FILE_NAME: $MESSAGE") ;;
  esac
done <<< "$VALIDATION_OUTPUT"

if [[ ${#ERRORS[@]} -gt 0 ]]; then
  printf -v COMBINED_ERRORS '%s\n' "${ERRORS[@]}"
  fail "Reviews need attention before publishing:"$'\n'"${COMBINED_ERRORS%$'\n'}"
elif [[ $VALIDATION_STATUS -ne 0 ]]; then
  fail "The review checker failed:"$'\n'"$VALIDATION_OUTPUT"
fi

if [[ ${#WARNINGS[@]} -gt 0 ]]; then
  printf -v COMBINED_WARNINGS '%s\n' "${WARNINGS[@]}"
  if ! confirm "Please check these before publishing:"$'\n'"${COMBINED_WARNINGS%$'\n'}"; then
    printf 'Publishing cancelled. Nothing was committed.\n'
    exit 1
  fi
fi

for POST_FILE in "${POST_FILES[@]}"; do
  git add -- "$POST_FILE" || fail "Git could not stage $(basename "$POST_FILE")."
done

if git diff --cached --quiet -- src/posts; then
  fail "There are no review changes to publish."
fi

# The pre-commit hook runs here. It renames the draft to match its date and
# title, looks up any new address, and refreshes the map files.
if [[ ${#POST_FILES[@]} -eq 1 ]]; then
  SUMMARY="${TITLES[0]}"
  COMMIT_MESSAGE="Publish ${TITLES[0]}"
else
  SUMMARY="${#POST_FILES[@]} reviews"
  COMMIT_MESSAGE="Publish ${#POST_FILES[@]} reviews"
fi
COMMIT_OUTPUT="$(git commit -m "$COMMIT_MESSAGE" 2>&1)" || fail "$COMMIT_OUTPUT"

BRANCH="$(git branch --show-current)"
if [[ -z "$BRANCH" ]]; then
  fail "The review was committed, but it can't be pushed because HEAD is not on a branch."
fi

PUSH_OUTPUT="$(git push origin "$BRANCH" 2>&1)" || fail "The review was committed locally but the push failed:"$'\n'"$PUSH_OUTPUT"
printf '%s\n' "$PUSH_OUTPUT"
printf 'Published %s to %s.\n' "$SUMMARY" "$BRANCH"
notify "Published $SUMMARY to $BRANCH."