#import "../tkf.typ": *
#tkf-note(id: "notes/2026-10-12-model-checking-theory-perspective.typ", title: "Model checking theory", tags: ("model-checking", "formal-methods", "verification"), author: "", date: "2026-10-12", api => [
#let transclude = api.transclude
#let notelink = api.notelink

From a theory perspective model checking is a constructive proof that an invariant holds on all states.
Ie we have a model which goes through a series of steps, and if we have a proof that is something like 'for state A the invariant holds, as well as state B, and C and..., and there are no other states' then that candidate invariant is true of the entire system.

])
