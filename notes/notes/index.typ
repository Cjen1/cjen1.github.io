#import "../tkf.typ": *
#tkf-note(id: "notes/index.typ", title: "Random notes", tags: (), author: "Cjen1", date: "2026-02-25", api => [
  #let transclude = api.transclude
  = Programming
  #transclude("2026-03-05-automerge.typ", mode: "title-link")
  #transclude("ai/index.typ", mode: "title-link")

  = Hobbies
  #transclude("2026-02-25-tapestry-lawns.typ", mode: "title-link")
  #transclude("2026-02-25-panel-glue-ups.typ", mode: "title-link")

  = Badmin things
  #transclude("2026-03-02-uk-insurance.typ", mode: "title-link")
  #transclude("2026-03-02-usa-taxes.typ", mode: "title-link")

])
