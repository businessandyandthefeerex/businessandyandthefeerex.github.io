#!/usr/bin/env bash

# Stage and publish a review, then push it to its current Git branch.
fail() {
  local message="${1:-Publishing failed}"
  printf '%s\n' "$message" >&2

  if [[ ! -t 0 || ! -t 1 ]]; then
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
  if [[ ! -t 0 || ! -t 1 ]] && command -v kdialog >/dev/null 2>&1; then
    kdialog --msgbox "$message" --title "Publish review" >/dev/null 2>&1
  elif [[ ! -t 0 || ! -t 1 ]] && command -v zenity >/dev/null 2>&1; then
    zenity --info --title="Publish review" --text="$message" >/dev/null 2>&1
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send "Publish review" "$message" >/dev/null 2>&1
  fi
}

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
  fail "Could not find the repository containing the _posts folder from: $SCRIPT_DIR"
fi

cd "$REPO_DIR" || fail "Could not open the repository: $REPO_DIR"

POST_FILES=()
if [[ $# -gt 0 ]]; then
  for POST_FILE in "$@"; do
    [[ "$POST_FILE" = /* ]] || POST_FILE="$REPO_DIR/$POST_FILE"
    POST_FILES+=("$POST_FILE")
  done
else
  while IFS= read -r POST_FILE; do
    [[ -n "$POST_FILE" ]] && POST_FILES+=("$REPO_DIR/$POST_FILE")
  done < <({ git diff --name-only -- _posts; git ls-files --others --exclude-standard -- _posts; } | sort -u)
fi

if [[ ${#POST_FILES[@]} -eq 0 ]]; then
  fail "No changed review files found in _posts."
fi

TITLES=()
VALID_VALIDATIONS=()
VALIDATION_ERRORS=()
for POST_FILE in "${POST_FILES[@]}"; do
  if [[ ! -f "$POST_FILE" ]]; then
    VALIDATION_ERRORS+=("$(basename "$POST_FILE") is missing from disk")
    continue
  fi

  VALIDATION_OUTPUT="$(ruby -ryaml -rdate -e '
    path = ARGV[0]
    parts = File.read(path).split(/^---\s*$/, 3)
    abort "Missing front matter in #{path}" unless parts.length >= 3
    data = YAML.safe_load(parts[1], permitted_classes: [Date, Time]) || {}
    required = %w[category layout title date rating meal address]
    missing = required.reject { |key| !data[key].nil? && !data[key].to_s.strip.empty? }
    abort "#{File.basename(path)} is missing front matter: #{missing.join(", ")}"
' "$POST_FILE" 2>&1)"
  if [[ $? -ne 0 ]]; then
    VALIDATION_ERRORS+=("$VALIDATION_OUTPUT")
    continue
  fi

  TITLE="$(ruby -ryaml -rdate -e '
    parts = File.read(ARGV[0]).split(/^---\s*$/, 3)
    print((YAML.safe_load(parts[1], permitted_classes: [Date, Time]) || {})["title"])
  ' "$POST_FILE")"
  TITLES+=("$TITLE")
  VALID_VALIDATIONS+=("$POST_FILE")
done

if [[ ${#VALIDATION_ERRORS[@]} -gt 0 ]]; then
  printf -v COMBINED_VALIDATION_ERRORS '%s\n' "${VALIDATION_ERRORS[@]}"
  fail "Front matter needs attention before publishing:${COMBINED_VALIDATION_ERRORS:+$'\n'}${COMBINED_VALIDATION_ERRORS%$'\n'}"
fi

for POST_FILE in "${VALID_VALIDATIONS[@]}"; do
  git add -- "$POST_FILE" || fail "Git could not stage $(basename "$POST_FILE")."
done

if git diff --cached --quiet -- _posts; then
  fail "There are no review changes to publish."
fi

if [[ ${#POST_FILES[@]} -eq 1 ]]; then
  COMMIT_MESSAGE="Publish ${TITLES[0]}"
else
  COMMIT_MESSAGE="Publish ${#POST_FILES[@]} reviews"
fi
COMMIT_OUTPUT="$(git commit -m "$COMMIT_MESSAGE" 2>&1)" || fail "$COMMIT_OUTPUT"
BRANCH="$(git branch --show-current)"
if [[ -z "$BRANCH" ]]; then
  fail "Cannot push: HEAD is not on a branch."
fi

PUSH_OUTPUT="$(git push origin "$BRANCH" 2>&1)" || fail "$PUSH_OUTPUT"
printf '%s\n' "$PUSH_OUTPUT"
if [[ ${#POST_FILES[@]} -eq 1 ]]; then
  SUMMARY="${TITLES[0]}"
else
  SUMMARY="${#POST_FILES[@]} reviews"
fi
printf 'Published %s to %s.\n' "$SUMMARY" "$BRANCH"
notify "Published $SUMMARY to $BRANCH."
