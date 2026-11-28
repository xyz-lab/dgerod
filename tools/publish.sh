#!/usr/bin/env bash
# Publish what is staged: commit it on a new branch, push the branch,
# fast-forward main to it, push main and wait for GitHub Pages to build.
#
# Usage: tools/publish.sh <branch> ["<commit message>"]
#
# Without a message, Claude Code (claude -p) proposes one from the staged diff
# and asks before using it. Unstaged changes are left untouched.

set -euo pipefail

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <branch> [\"<commit message>\"]" >&2
  exit 1
fi
branch=$1
message=${2:-}

cd "$(git rev-parse --show-toplevel)"

fail() { echo "Error: $*" >&2; exit 1; }

# --- Checks ---------------------------------------------------------------

[ "$(git branch --show-current)" = main ] || fail "run it from main (now on $(git branch --show-current))."
git diff --cached --quiet && fail "nothing is staged."
git show-ref --quiet "refs/heads/$branch" && fail "branch '$branch' already exists."

git fetch -q origin
[ "$(git rev-parse main)" = "$(git rev-parse origin/main)" ] \
  || fail "main is not in sync with origin/main; pull or push first."

# Every src="..." added in staged HTML must point to a file that is staged
# or already tracked, so the page does not go live with a broken image.
missing=()
while IFS= read -r file; do
  dir=$(dirname "$file")
  while IFS= read -r ref; do
    ref=${ref%%[?#]*}
    case "$ref" in
      ''|http:*|https:*|//*|data:*|*'{{'*|*'{%'*) continue ;;
      /*) path=${ref#/} ;;
      *)  path=$(realpath -m --relative-to=. "$dir/$ref") ;;
    esac
    git cat-file -e ":$path" 2>/dev/null || missing+=("$file -> $ref")
  done < <(git diff --cached -U0 -- "$file" | grep '^+' | grep -oE 'src="[^"]*"' | sed 's/^src="//; s/"$//')
done < <(git diff --cached --name-only --diff-filter=AM -- '*.html' '*.md' \
           ':(exclude)README.md' ':(exclude)docs/' ':(exclude)tools/' ':(exclude)vendor/' ':(exclude)_site/')

if [ ${#missing[@]} -gt 0 ]; then
  echo "Error: these files are referenced but not staged or tracked:" >&2
  printf '  %s\n' "${missing[@]}" >&2
  exit 1
fi

echo "Staged:"
git diff --cached --stat
echo

# --- Commit message -------------------------------------------------------

if [ -z "$message" ]; then
  command -v claude >/dev/null || fail "no message given and claude is not installed."
  echo "Asking Claude for a commit message..."
  prompt="Write a git commit message for the staged diff of a personal website, given on stdin.
Follow the style of these recent commit subjects:
$(git log -15 --format='- %s' main)
Rules: one subject line in English, at most 72 characters, no trailing period,
'Page: what changed' when it touches one page. Add a short body only if the
subject cannot say it all. Reply with the message only: no quotes, no code fences."
  message=$(git diff --cached | claude -p "$prompt" --model haiku --tools "" --no-session-persistence) \
    || fail "claude did not return a message."
  [ -n "$message" ] || fail "claude returned an empty message."

  while true; do
    echo
    echo "----"
    echo "$message"
    echo "----"
    read -r -p "Use this message? [Y]es / [e]dit / [n]o: " answer
    case "${answer:-y}" in
      [YySs]*) break ;;
      [Ee]*)
        tmp=$(mktemp)
        printf '%s\n' "$message" > "$tmp"
        "${VISUAL:-${EDITOR:-nano}}" "$tmp"
        message=$(grep -v '^#' "$tmp" || true)
        rm -f "$tmp"
        [ -n "$message" ] || fail "empty message, nothing published."
        ;;
      [Nn]*) echo "Cancelled, nothing published."; exit 0 ;;
    esac
  done
fi

# --- Commit, merge and push -----------------------------------------------

git switch -q -c "$branch"
git commit -q -m "$message"
git push -q -u origin "$branch"
git switch -q main
git merge --ff-only -q "$branch"
git push -q origin main
commit=$(git rev-parse --short=7 HEAD)
echo "Pushed $commit to $branch and main."

# --- Wait for GitHub Pages ------------------------------------------------

if ! command -v gh >/dev/null; then
  echo "gh not found; check the Pages build on GitHub."
  exit 0
fi

echo -n "Waiting for GitHub Pages"
for _ in $(seq 1 60); do
  status=$(gh api 'repos/{owner}/{repo}/pages/builds/latest' \
    --jq '.status + " " + .commit[0:7]' 2>/dev/null || true)
  case "$status" in
    "built $commit") echo; echo "Published. CSS may be cached for ~10 min (Ctrl+Shift+R)."; exit 0 ;;
    "errored $commit") echo; fail "the Pages build failed; check the repository's Actions/Pages tab." ;;
  esac
  echo -n "."
  sleep 5
done
echo
echo "Pages has not finished after 5 minutes; check it on GitHub."
