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

The target is for a user to be able to open a note and transclude other notes in.
The problem is that this immediately becomes a metadata nightmare.

== Embeddings

This will eventually be transcluded in but in the meantime:

When doing metaprogramming, one common technique is to embed a DSL into another language.
Specifically for tagless-final embeddings if you provide the type of the environment/eval function, then you can write the DSL using that.

== The API arg

Every note is thus a function from an API to a content block. 

This means that we can do two separate evaluation passes, one to shallowly evaluate the note and record metadata, and one to draw the rest of the fucking owl. 

This means that the actual note has an extremely rich and extensible metadata environment. 
On a more practical note this means that we can have depth tracking of transcluded preventing infinite cycles etc.

= Fighting with Typst

== Rendering engine

Typst does not like impure functions.
The only thing it does give you is a "context" which in practice is a monadic wrapper.
*Except* that wrapper is only for content, and so breaks horribly whenever you start evaluating it multiple times etc. 

== Cyclic includes

Typst only allows you to include each file at most once. 
So dynamic loading of files is a huge program. 
Instead we load everything at once (all the note lambdas) and then evaluate them dynamically.
])
