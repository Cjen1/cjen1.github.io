#!/usr/bin/env bash
set -euo pipefail

metadata="${1:-generated/metadata.json}"

if [[ ! -f "$metadata" ]]; then
  echo "Metadata file not found: $metadata" >&2
  echo "Run 'tkf build' before metadata validation." >&2
  exit 1
fi

failed=0

invalid_tags="$(
  jq -r '
    .[]
    | select(.value.kind? == "note")
    | select((.value.data.tags | type) != "array")
    | "\(.value.data.id): tags must be an array, got \(.value.data.tags | type)"
  ' "$metadata"
)"
if [[ -n "$invalid_tags" ]]; then
  echo "Invalid note tags:" >&2
  echo "$invalid_tags" >&2
  failed=1
fi

dangling_edges="$(
  jq -r '
    ([.[] | select(.value.kind? == "note") | .value.data.id] | INDEX(.)) as $notes
    | .[]
    | select(.value.kind? == "edge")
    | select($notes[.value.data.to] == null)
    | "\(.value.data.from): \(.value.data.relation) targets unknown note \(.value.data.to)"
  ' "$metadata"
)"
if [[ -n "$dangling_edges" ]]; then
  echo "Dangling note edges:" >&2
  echo "$dangling_edges" >&2
  failed=1
fi

invalid_indexes="$(
  jq -r '
    ([.[] | select(.value.kind? == "note") | .value.data.id] | INDEX(.)) as $notes
    | .[]
    | select(.value.kind? == "tag-index")
    | select(
        $notes[.value.data.source] == null
        or (.value.data.tags | type) != "array"
        or (.value.data.match != "any" and .value.data.match != "all")
      )
    | "\(.value.data.source): invalid tag-index selector"
  ' "$metadata"
)"
if [[ -n "$invalid_indexes" ]]; then
  echo "Invalid tag indices:" >&2
  echo "$invalid_indexes" >&2
  failed=1
fi

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

echo "PASS: metadata references and shapes are valid"
