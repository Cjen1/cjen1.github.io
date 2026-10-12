#import "../tkf.typ": *
#tkf-note(id: "notes/2026-10-12-model-checking-inductive-invariant.typ", title: "Inductive invariants for model checking", tags: ("model-checking", "formal-methods", "verification"), author: "", date: "2026-10-12", api => [
#let transclude = api.transclude
#let notelink = api.notelink

Suppose that we have an infinite model. In that case exploration is not feasible.
Instead we can find an inductive invariant, prove that it is inductive, then prove that it proves our invariants.

For example suppose we want to prove `Inv`.
Then we discover some other invariant `SysInv` and show:
- `SysInv` holds for all `Init`
- `SysInv` holds for all `Next`
- `SysInv` proves `Inv`

])
