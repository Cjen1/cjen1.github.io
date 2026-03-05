#import "../tkf.typ": *
#tkf-note(id: "tools/2026-03-05-excali-present.typ", title: "Excali-Present", tags: (), author: "", date: "2026-03-05", api => [
#let transclude = api.transclude
#let notelink = api.notelink

#link("https://github.com/cjen1/excali-present")[Excali-Present] is a small wrapper and tooling around excalidraw to make it useful for drawing animations for presentations.

The idea is that you enclose each slide in a named frame, and then animate slides in frames going left-to-right.
This workspace is saved to document.json in the animations folder (with versioning in `.versions`).

== Notes on usage
- Small lines in excalidraw can end up with a crows mark, which is very noisy.

== Architecture
Roughly the wrapper around excalidraw has three functions.
1. Loading of the docs from disk (via a http call to the server).
2. Frequent syncs to the server and back to the disk.
3. Rendering function which extracts all frames with the same name and turns them into numbered subslides.

The frontend submits HTTP requests to the server side which functionally acts to write/read these to/from disk.

=== NOTE
This is intentionally insecure (HTTP, no auth) to make the system substantially simpler.

=== Alternatives

This was previously using a more complex #transclude("../notes/2026-03-05-automerge.typ", mode: "title-link") implementation.
However the frequency of updates, and the lack of good compaction made this not scale effectively.
])
