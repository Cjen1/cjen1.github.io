#!/usr/bin/env bash
set -euo pipefail

output_dir="${1:-dist}"
test -d "$output_dir"

# The tkf release pinned in flake.lock does not yet copy static/ itself.
# Exclude submodule Git metadata from the published files.
if [ -d static ]; then
  tar -C static --exclude='.git' -cf - . | tar -C "$output_dir" -xf -
fi

test -s "$output_dir/adelaide-running/index.html"
test -s "$output_dir/adelaide-running/data.js"
