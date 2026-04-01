#import "tkf.typ": *
#tkf-note(id: "linkdump.typ", title: "Linkdump", tags: ("links", "data"), author: "Cjen1", date: "2026-04-01", api => [
  #let dump-link(url, date, title: none, tags: (), notes: none) = [
    #metadata((
      schema: "tkf-meta-v1",
      kind: "linkdump",
      data: (
        url: url,
        date: date,
        title: title,
        tags: tags,
        notes: notes,
      ),
    ))<tkf-meta>
    - #link(url)[#if title == none { url } else { title }] (#date)
  ]

  = Recent links

  #dump-link("https://github.com/cjen1/typst-knowledge-forests", "2026-03-01", title: "typst-knowledge-forests")
  #dump-link("https://sr.ht/~jonsterling/forester/", "2026-03-02", title: "Forester")
  #dump-link("https://github.com/cjen1/excali-present", "2026-03-03", title: "Excali-Present")
  #dump-link("https://automerge.org", "2026-03-04", title: "Automerge")
  #dump-link("https://github.com/cjen1/monzo-us-tax-scripts", "2026-03-05", title: "monzo-us-tax-scripts")
  #dump-link("https://www.ponylang.io/blog/2026/02/teaching-claude-to-write-pony/", "2026-03-06", title: "Teaching Claude to Write Pony")
  #dump-link("https://github.com/microsoft/CCF", "2026-03-07", title: "Microsoft CCF")
  #dump-link("https://github.com/cjen1", "2026-03-08", title: "cjen1 on GitHub")
  #dump-link("https://discuss.systems/@Cjen1", "2026-03-09", title: "Cjen1 on Mastodon")
  #dump-link("https://doi.org/10.1145/3341301.3359651", "2026-03-10", title: "I4 paper")
  #dump-link("https://doi.org/10.1145/2908080.2908118", "2026-03-11", title: "Ivy paper")
  #dump-link("https://github.com/cjen1/cjen1.github.io", "2026-03-12", title: "This site")
])
