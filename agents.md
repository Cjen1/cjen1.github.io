# agents.md

This is a personal knowledge forest built with [typst-knowledge-forests (TKF)](https://github.com/cjen1/typst-knowledge-forests).

## Key files

- [README.md](README.md) — Build and usage instructions
- [notes/tkf.typ](notes/tkf.typ) — Typst runtime library (public API: `kt-note`, `transclude`, `notelink`, `kt-backlinks`)

## Structure

Notes live in `notes/` as `.typ` files. Each note defines a single `#kt-note(...)` with a body closure that receives an `api` object. Use `api.transclude("relative/path.typ")` and `api.notelink("relative/path.typ")` for cross-references — paths are relative to the calling note's directory. Use `api.static-link("apps/example/", text: "Open app")` for static files — paths are relative to `static/` and URLs resolve from the site root.

`tkf build` runs two passes: a query pass to extract metadata (edges, titles, tags) and a render pass to compile each note to HTML in `dist/`. The pinned version does not copy `static/`; run `bash tests/copy-static.sh` after the build to copy static files into `dist/`. Both CI workflows do this.
