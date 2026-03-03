#import "tkf.typ": *
#kt-note(id: "index.typ", title: "Jentek.dev", tags: (), author: "Cjen1", date: "2026-02-25", api => [
  #let transclude = api.transclude

  Welcome to my forest of notes.

  = About Me

  I enjoy building infrastructure which exemplifies the phrase: "What doesn't exist can't break".
  For me this means ensuring reliability by solving a problem in the simplest possible way.

  I'm currently working for Microsoft as a research engineer on the #link("https://github.com/microsoft/CCF")[CCF project] which can be summarised as a sensible distributed confidential ledger using TEEs.

  I am on #link("https://github.com/cjen1")[Github] and #link("https://discuss.systems/@Cjen1")[Mastodon].
  
  = Notes

  #transclude("notes/index.typ", mode: "title-link")
  #transclude("paper-reviews/index.typ", mode: "title-link")
  #transclude("tools/index.typ", mode: "title-link")

  This project is built using my #link("https://github.com/cjen1/typst-knowledge-forests")[TKF (Typst knowledge forests)] tool which is based on #link("https://sr.ht/~jonsterling/forester/")[Jon Sterling's forester].
])
