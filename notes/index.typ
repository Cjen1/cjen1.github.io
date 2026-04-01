#import "tkf.typ": *
#tkf-note(id: "index.typ", title: "Jentek.dev", tags: (), author: "Cjen1", date: "2026-02-25", api => [
  #let transclude = api.transclude

  Welcome to my forest of notes.

  = About Me

  I enjoy building infrastructure which exemplifies the phrase: "What doesn't exist can't break".
  For me this means ensuring reliability by solving a problem in the simplest possible way.

  I'm currently working for Microsoft as a research engineer on the #link("https://github.com/microsoft/CCF")[CCF project] which can be summarised as a sensible distributed confidential ledger using TEEs.

  I am on #link("https://github.com/cjen1")[Github] and #link("https://discuss.systems/@Cjen1")[Mastodon].

  #let dumped-links = (
    api.metadata
      .filter(entry => entry.func == "metadata" and entry.value.schema == "tkf-meta-v1" and entry.value.kind == "linkdump")
      .map(entry => entry.value.data)
      .sorted(key: entry => entry.at("date", default: ""))
      .rev()
  )
  #let latest-links = if dumped-links.len() <= 10 { dumped-links } else { dumped-links.slice(0, 10) }

  = Latest Links

  #if latest-links.len() == 0 [
    _No dumped links yet._
  ] else [
    #for entry in latest-links [
      #let url = entry.at("url", default: "")
      #let title = entry.at("title", default: none)
      - #link(url)[#if title == none { url } else { title }] (#entry.at("date", default: ""))
    ]
  ]
  
  = Notes

  #transclude("tools/index.typ", mode: "title-link")
  #transclude("notes/index.typ", mode: "title-link")
  #transclude("paper-reviews/index.typ", mode: "title-link")

  This project is built using my #link("https://github.com/cjen1/typst-knowledge-forests")[TKF (Typst knowledge forests)] tool which is based on #link("https://sr.ht/~jonsterling/forester/")[Jon Sterling's forester].
])
