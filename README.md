# Build the site

```
tkf build
```

Files in `static/` are copied into the root of `dist/` during `tkf build`.
For example, `static/apps/example/index.html` is served at `/apps/example/`.
The `static/` directory is optional.

Inside a note, use the static link helper exposed by `api`:

```typ
#let static-link = api.static-link
#static-link("apps/example/", text: "Open the example app")
```

The path passed to `static-link` is relative to `static/`; generated URLs start
at the site root. You can also use a regular Typst link with a root-relative
URL, such as `#link("/apps/example/")[Open the example app]`.

# Add new note

```
tkf new 
