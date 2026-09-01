#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

jobs="$(( ($(nproc) + 1) >> 1 ))"
fixture_html="$(mktemp --suffix=.html)"
diagnostics="$(mktemp)"
trap 'rm -f "$fixture_html" "$diagnostics"' EXIT

typst compile --features html --root . -j "$jobs" \
  tests/recipe-card-fixture.typ "$fixture_html"

perl -e '
use strict;
use warnings;

sub read_file {
  my ($path) = @_;
  open my $fh, q{<}, $path or die "Failed to read $path: $!\n";
  local $/;
  return <$fh>;
}

sub body {
  my ($html) = @_;
  $html =~ s{.*?<body>}{}s or die "Missing opening body element\n";
  $html =~ s{</body>.*}{}s or die "Missing closing body element\n";
  $html =~ s/>\s+</></g;
  $html =~ s/^\s+|\s+$//g;
  return $html;
}

my ($actual_path, $expected_path) = @ARGV;
my $actual = body(read_file($actual_path));
my $expected = body(read_file($expected_path));

die "Recipe card HTML differs from tests/recipe-card-expected.html\n"
  unless $actual eq $expected;
' "$fixture_html" tests/recipe-card-expected.html

perl -e '
use strict;
use warnings;

open my $fh, q{<}, "site.css" or die "Failed to read site.css: $!\n";
local $/;
my $css = <$fh>;

my @required = (
  qr/recipe-card\s*\{[^}]*width:\s*max-content;/s,
  qr/recipe-card\s*\{[^}]*max-width:\s*calc\(100vw - 2rem\);/s,
  qr/recipe-card\s*\{[^}]*padding-bottom:\s*1rem;/s,
  qr/recipe-card\s*\{[^}]*overflow-x:\s*auto;/s,
  qr/recipe-card\s*\{[^}]*transform:\s*translateX\(-50%\);/s,
  qr/\.recipe-card-table\s*\{[^}]*border-collapse:\s*collapse;/s,
  qr/\.recipe-action-cell\s*\{[^}]*text-align:\s*center;/s,
  qr/\.recipe-gap\s*\{[^}]*border:\s*0;/s,
);

for my $rule (@required) {
  die "Missing required recipe card CSS: $rule\n" unless $css =~ $rule;
}
' 

while IFS='|' read -r recipe_case expected; do
  if typst compile --features html --root . -j "$jobs" \
      --input "recipe-case=$recipe_case" \
      tests/recipe-card-invalid.typ "$fixture_html" \
      >"$diagnostics" 2>&1; then
    echo "Expected $recipe_case to fail" >&2
    exit 1
  fi

  if ! grep -Fq "$expected" "$diagnostics"; then
    echo "Expected $recipe_case diagnostic to contain: $expected" >&2
    cat "$diagnostics" >&2
    exit 1
  fi
done <<'CASES'
invalid-root|recipe must return exactly one ingredient or action node
invalid-input|recipe action inputs must be ingredient or action nodes
named-action-argument|recipe actions do not accept named arguments
named-ingredient-argument|recipe ingredients do not accept named arguments
invalid-quantity|recipe quantity must be a decimal scalar with an optional unit, or "?"
non-string-quantity|recipe quantity must be a string
CASES

echo "PASS: recipe card renderer"
