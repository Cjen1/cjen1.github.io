#import "../tkf.typ": *
#tkf-note(id: "notes/2026-10-12-model-checking-symmetry-reduction.typ", title: "model-checking-symmetry-reduction", tags: ("model-checking", ), author: "", date: "2026-10-12", api => [
#let transclude = api.transclude
#let notelink = api.notelink

In model checking a symmetry reduction is a technique where rather than exploring every state, we explore one representative of each equivalence class of states.
This is generally done by reducing every state we explore to the representative of their equivalence class and then continuing the search from there.

To make this specific, the most commonly used equivalence class is the node / participant ordering.
Suppose we have a set of participants, labelled by an integer $1, dots, N$.
If our invariant only is on a per participant basis, then we can take every state, and generate the full equivalence class by working through every permutation of participant labels.
The normal thing to do is to sort the equivalence class somehow (in the limit just the in-memory representation) and use the lowest element as the representative.

Diving into the theory a bit, a symmetry reduction $g$ is only safe if:
- It preserves the initial state: $s in I <=> g(s) in I$
- It preserves transitions: $s -> t <=> g(s) -> g(t)$
- It preserves labels (invariants): $L(s) = L(g(s))$
])
