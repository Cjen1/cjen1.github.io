#import "../tkf.typ": *
#tkf-note(id: "notes/index.typ", title: "Random notes", tags: (), author: "Cjen1", date: "2026-02-25", api => [
  #let transclude = api.transclude
  = Programming
  #tag-index(("software-engineering", "crdt", "local-first"), "any")
  #transclude("ai/index.typ", mode: "title-link")

  = Formal methods
  #tag-index(("formal-methods",), "any")

  = Hobbies
  #transclude("2026-02-25-tapestry-lawns.typ", mode: "title-link")
  #transclude("2026-02-25-panel-glue-ups.typ", mode: "title-link")

  = Badmin things
  #tag-index(("personal-admin",), "any")
])
