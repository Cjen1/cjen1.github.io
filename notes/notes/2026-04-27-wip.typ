#import "../tkf.typ": *
#tkf-note(id: "notes/2026-04-27-wip.typ", title: "WIP", tags: (), author: "", date: "2026-04-27", api => [
#let transclude = api.transclude
#let notelink = api.notelink

= BocPy w/ Polars data analysis pipeline

The problem with dataflow processing in python is that you are either limited to a single core, or multi-threaded but paying through the nose for serialisation costs.

Optimally you'd want to define some kind of simple dataflow model and then just pass memory between the threads, however the sync becomes extremely expensive.
So BocPy has cowns which can then be used to pass data to multiple processors, which then start processing immediately.For example:

```python
df = Cown(None)
@when(df)
def _(df):
  df = ...

proc1 = Cown(None)
@when(proc1, df)
def _(proc1):
  proc1 = ...

proc2 = Cown(None)
@when(proc2, df)
def _(proc2):
  proc2 = ...

@when(proc1, proc2)
def _(proc1, proc2):
  plot(proc1, proc2)
```

This is directionally what we want but not quite, still need some way to say that proc1 and proc2 want read-only versions of df which should be feasible?
])
