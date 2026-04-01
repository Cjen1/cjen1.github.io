# Linkdump Metadata Site Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a data-source `linkdump` note to this TKF site and render the latest 10 dumped links on the homepage.

**Architecture:** Keep the feature entirely in Typst content. A new `notes/linkdump.typ` note defines a local helper that emits `tkf-meta-v1` metadata records with `kind: "linkdump"` while also rendering a readable list on its own page. The root `notes/index.typ` then queries `api.metadata`, sorts those records by ISO date, and renders the latest 10 links.

**Tech Stack:** Typst notes, TKF metadata/query pipeline, `nix develop -c tkf build`

---

## File Map

- Create: `notes/linkdump.typ` - data-source note with a local `dump-link` helper and seeded link entries
- Modify: `notes/index.typ` - homepage section that queries and renders the latest 10 dumped links
- Modify: `generated/metadata.json` - regenerated build artifact showing `linkdump` records
- Modify: `dist/index.html` - regenerated homepage artifact showing the new latest-links section
- Modify: `dist/linkdump.html` - regenerated page artifact for the new note
- Create: `docs/superpowers/plans/2026-04-01-linkdump-metadata-site.md` - this plan

### Task 1: Add the linkdump data-source note

**Files:**
- Create: `notes/linkdump.typ`
- Test: `generated/metadata.json`
- Test: `dist/linkdump.html`

- [ ] **Step 1: Write the failing verification target**

The new note must define a local helper and emit at least 12 `linkdump` metadata records so the homepage can later prove that it truncates to 10.

Create `notes/linkdump.typ` with this exact structure:

```typst
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

  #dump-link("https://example.com/01", "2026-03-01", title: "Example 01")
  #dump-link("https://example.com/02", "2026-03-02", title: "Example 02")
  #dump-link("https://example.com/03", "2026-03-03", title: "Example 03")
  #dump-link("https://example.com/04", "2026-03-04", title: "Example 04")
  #dump-link("https://example.com/05", "2026-03-05", title: "Example 05")
  #dump-link("https://example.com/06", "2026-03-06", title: "Example 06")
  #dump-link("https://example.com/07", "2026-03-07", title: "Example 07")
  #dump-link("https://example.com/08", "2026-03-08", title: "Example 08")
  #dump-link("https://example.com/09", "2026-03-09", title: "Example 09")
  #dump-link("https://example.com/10", "2026-03-10", title: "Example 10")
  #dump-link("https://example.com/11", "2026-03-11", title: "Example 11")
  #dump-link("https://example.com/12", "2026-03-12", title: "Example 12")
])
```

- [ ] **Step 2: Run build to verify the new note is picked up**

Run: `nix develop -c tkf build`
Expected: PASS, with regenerated `generated/metadata.json` and `dist/linkdump.html` containing the new note.

- [ ] **Step 3: Verify metadata output contains linkdump records**

Run: `rg '"kind": "linkdump"|"url": "https://example.com/12"|"date": "2026-03-12"' generated/metadata.json`
Expected: three matches showing the new `linkdump` record kind and the latest seeded example entry.

- [ ] **Step 4: Verify the note page renders readable rows**

Run: `rg 'Example 12|https://example.com/12|2026-03-12' dist/linkdump.html`
Expected: matches showing the page renders a clickable label and visible date text.

- [ ] **Step 5: Commit**

```bash
git add notes/linkdump.typ generated/metadata.json dist/linkdump.html docs/superpowers/plans/2026-04-01-linkdump-metadata-site.md
git commit -m "feat: add linkdump data source"
```

### Task 2: Render latest linkdump entries on the homepage

**Files:**
- Modify: `notes/index.typ`
- Test: `dist/index.html`
- Test: `generated/metadata.json`

- [ ] **Step 1: Write the homepage query block**

Update `notes/index.typ` by adding this block after the introductory text and before the `= Notes` section:

```typst
  #let dumped-links = (
    api.metadata
      .filter(entry => entry.func == "metadata" and entry.value.schema == "tkf-meta-v1" and entry.value.kind == "linkdump")
      .map(entry => entry.value.data)
      .sorted(key: entry => entry.at("date", default: ""))
      .rev()
  )
  #let latest-links = if dumped-links.len() <= 10 { dumped-links } else { dumped-links.slice(0, 10) }

  = Latest Links

  #if latest-links.len() == 0 {
    _No dumped links yet._
  } else {
    #for entry in latest-links {
      - #link(entry.at("url", default: ""))[#entry.at("title", default: entry.at("url", default: ""))] (#entry.at("date", default: ""))
    }
  }
```

- [ ] **Step 2: Run build to regenerate the homepage**

Run: `nix develop -c tkf build`
Expected: PASS, with `dist/index.html` updated to include the latest-links section.

- [ ] **Step 3: Verify the homepage shows the latest 10 entries only**

Run: `rg 'Latest Links|https://example.com/12|https://example.com/03|https://example.com/02|https://example.com/01' dist/index.html`
Expected: matches for `Latest Links`, `https://example.com/12`, and `https://example.com/03`; no matches for `https://example.com/02` or `https://example.com/01` because the list is capped at 10 newest entries.

- [ ] **Step 4: Verify ordering remains descending by ISO date**

Run: `python - <<'PY'
from pathlib import Path
html = Path('dist/index.html').read_text()
assert html.index('https://example.com/12') < html.index('https://example.com/11')
assert html.index('https://example.com/11') < html.index('https://example.com/10')
assert html.index('https://example.com/04') < html.index('https://example.com/03')
print('ordering ok')
PY`
Expected: prints `ordering ok`.

- [ ] **Step 5: Commit**

```bash
git add notes/index.typ dist/index.html generated/metadata.json dist/linkdump.html
git commit -m "feat: show latest dumped links on homepage"
```

### Task 3: Run final verification and capture the finished state

**Files:**
- Modify: `notes/linkdump.typ` (only if build verification reveals a Typst issue)
- Modify: `notes/index.typ` (only if build verification reveals a Typst issue)
- Test: `generated/metadata.json`
- Test: `dist/index.html`
- Test: `dist/linkdump.html`

- [ ] **Step 1: Run the final build from a clean working tree state**

Run: `nix develop -c tkf build`
Expected: PASS and all generated artifacts remain up to date.

- [ ] **Step 2: Verify the homepage and note artifacts together**

Run: `rg 'Latest Links|https://example.com/12|https://example.com/03' dist/index.html && rg 'Recent links|Example 12|2026-03-12' dist/linkdump.html && rg '"kind": "linkdump"' generated/metadata.json`
Expected: all commands succeed, confirming metadata extraction and both rendered views.

- [ ] **Step 3: Verify git status only contains the intended feature files**

Run: `git status --short`
Expected: clean working tree if all generated files were committed in Tasks 1-2, or only intentional edits if a tiny final fix was required.

- [ ] **Step 4: If build output changed, make the smallest Typst-only fix**

Use one of these exact patterns if a fix is needed:

```typst
#metadata((schema: "tkf-meta-v1", kind: "linkdump", data: (url: url, date: date, title: title, tags: tags, notes: notes)))<tkf-meta>

#let latest-links = if dumped-links.len() <= 10 { dumped-links } else { dumped-links.slice(0, 10) }

- #link(entry.at("url", default: ""))[#entry.at("title", default: entry.at("url", default: ""))] (#entry.at("date", default: ""))
```

- [ ] **Step 5: Commit**

```bash
git add notes/linkdump.typ notes/index.typ generated/metadata.json dist/index.html dist/linkdump.html
git commit -m "test: verify linkdump metadata flow"
```
