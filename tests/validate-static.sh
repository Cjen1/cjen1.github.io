#!/usr/bin/env bash
set -euo pipefail

test -s dist/adelaide-running/index.html
test -s dist/adelaide-running/data.js

# tkf now copies static/ natively, including the submodule's Git pointer file.
# Remove only this generated copy, never the source submodule's metadata.
if [ -f dist/adelaide-running/.git ]; then
  rm -- dist/adelaide-running/.git
fi
test ! -e dist/adelaide-running/.git
