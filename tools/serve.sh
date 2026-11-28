#!/usr/bin/env bash
# Preview the site locally with Jekyll at http://localhost:4000.
# The site rebuilds when a file changes; reload the browser. Ctrl+C stops it.
#
# Usage: tools/serve.sh [jekyll serve options]
#   tools/serve.sh                  # the site as it will be published
#   tools/serve.sh --drafts         # ... plus the drafts of blog/_drafts/
#   tools/serve.sh --port 4001      # if port 4000 is busy
#
# The first time it installs the gems into vendor/bundle (see the user manual
# for the system packages Ruby needs).

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

command -v bundle >/dev/null || {
  echo "Error: bundle not found; install Ruby first (see docs/user-manual.md)." >&2
  exit 1
}

bundle config set --local path vendor/bundle
bundle check >/dev/null 2>&1 || bundle install

exec bundle exec jekyll serve "$@"
