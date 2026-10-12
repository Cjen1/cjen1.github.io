#import "../tkf.typ": *
#tkf-note(id: "notes/2026-10-12-model-checking-symmetric-invariants.typ", title: "Conjecture: Inductive invariants are a symmetry reduction", tags: ("model-checking", "conjecture", "formal-methods", "verification"), author: "", date: "2026-10-12", api => [
#let transclude = api.transclude
#let notelink = api.notelink

For model checking we have a model and we prove invariants about that model by generating every state and explicitly checking the invariant on that state.

#transclude("2026-10-12-model-checking-theory-perspective.typ")

We can reduce this work by using a symmetry reduction.

#transclude("2026-10-12-model-checking-symmetry-reduction.typ")

So we only have to check one representative from each equivalence class.

We can also reduce that work by instead finding an inductive invariant and checking that.

#transclude("2026-10-12-model-checking-inductive-invariant.typ")

My claim is that finding an inductive invariant is simply reducing the system to a single equivalence class that we then check.
The obvious issue being that the inductive invariant for things like Raft is not concrete, and often relies on ghost variables for commit evidence etc.

This leads to the following points.

#table(
  columns: 3,
  table.header[][Reduction][Cost],
  [No reduction], [None], [Free],
  [Id permutations], [Slight], [Cheap],
  [Finitisation], [Substantial], [Expensive],
  [...], [...], [...],
  [Inductive Invariant], [Complete], [Uncomputable],
)

The question then is: What is the minimum number of states necessary to check to satisfy the inductive invariant?
Or: Can we constructively go from a spec and the invariants, directly to the best possible computable symmetry reduction?
])
