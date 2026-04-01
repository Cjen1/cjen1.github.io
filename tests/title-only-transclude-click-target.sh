#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

nix develop -c tkf build >/tmp/tkf-build-title-only-transclude.log

perl -e '
use strict;
use warnings;

sub read_file {
  my ($path) = @_;
  open my $fh, q{<}, $path or die "Failed to read $path: $!\n";
  local $/;
  return <$fh>;
}

my $index_html = read_file("dist/index.html");
my $inline_html = read_file("dist/notes/ai/2026-03-21-alignment-skill.html");
my $site_css = read_file("site.css");

my $wrapped_title_link = qr{
  <tkf-transclusion\s+data-mode="title-link">
    \s*<a\s+href="/tools/index\.html">
    \s*<tkf-transclusion-title-div>
    \s*<tkf-transclusion-title>Tools</tkf-transclusion-title>
    \s*<tkf-transclusion-link>tools/index\.typ</tkf-transclusion-link>
    \s*</tkf-transclusion-title-div>
    \s*</a>
  \s*</tkf-transclusion>
}xs;

my $legacy_narrow_link = qr{
  <tkf-transclusion>
    \s*<tkf-transclusion-title-div>
    (?:(?!</tkf-transclusion-title-div>).)*
    <tkf-transclusion-link>
      \s*<a\s+href="/tools/index\.html">tools/index\.typ</a>
    \s*</tkf-transclusion-link>
    (?:(?!</tkf-transclusion-title-div>).)*
    </tkf-transclusion-title-div>
  \s*</tkf-transclusion>
}xs;

if ($index_html !~ $wrapped_title_link) {
  die "Expected title-only transclude header to be wrapped by a single anchor\n";
}

if ($index_html =~ $legacy_narrow_link) {
  die "Found legacy title-only transclude markup with a narrow link target\n";
}

if (index($index_html, q{<tkf-transclusion data-mode="title-link"><a href="/tools/index.html">}) == -1) {
  die "Expected title-only transclude markup to carry a title-link mode marker\n";
}

if ($site_css !~ /tkf-transclusion\[data-mode="title-link"\]\s*>\s*a\s*\{/) {
  die "Expected transclusion anchor CSS to target only title-link transclusions\n";
}

if ($site_css =~ /tkf-transclusion\s*>\s*a\s*\{/) {
  die "Found transclusion anchor CSS that still applies to every direct child link\n";
}

if (index($inline_html, q{<tkf-transclusion-inline>}) == -1) {
  die "Inline transclusion markup disappeared during verification\n";
}

print "PASS: title-only transclude header is fully linked\n";
'
