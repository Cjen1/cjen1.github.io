#import "../tkf.typ": *
#tkf-note(id: "tools/2026-03-02-typst-knowledge-forests.typ", title: "typst-knowledge-forests", tags: (), author: "Cjen1", date: "2026-03-02", api => [
#let transclude = api.transclude

#link("https://github.com/cjen1/typst-knowledge-forests")[TKF] aims to replicate the experience of #link("https://sr.ht/~jonsterling/forester/")[Jon Sterling's forester] and improve on the experience using typst as the host language.

= Knowledge Forests

To summarise the manifesto:
Forester is a tool for managing a forest of evergreen notes.
This that each note should express a single thing, and as such can be `#transclude`d into other notes where relevant.

The end result is that a rough blog post can be constructed by transcluding many notes together.
This is a similar approach to the notecard approach discussed in Robert Pirsig's Lila.

Additionally by virtue of expressing a single idea, they tend to be scrappier - unfinished and unpolished, and hence have lower activation energy to write.

= Implementation

The desired UX is that a user can write a note, and `#transclude` in other notes.
Additionally notes should maintain backlinks to where they are called from.

== The two pass system

We use two passes for every file.
The aim of the first pass is to generate `generated/manifest.json` which is a simple mapping from id to file, and `generated/metadata.json` which is arbitrary metadata about the system.
Then the second pass takes a single `note.typ` file and the manifest and metadata, and uses the manifest to look up the bodies of files to transclude, while the metadata is used to construct backlinks.

== Infinite inclusion
The first problem is that using `#include` directly requires that the forest is a DAG which cannot be guaranteed.
Specifically typst eagerly evaluates an included file and hence barfs whenever it hits a cyclic include.

So the first problem is to make the body of a note lazily evaluated.

This is done by wrapping the text in a lambda:
```
tkf-note(..., _ => [
  #transclude(...)
])
```

Rendering then becomes extracting and evaluating this lambda, and also allows for depth limited evaluation.
])
