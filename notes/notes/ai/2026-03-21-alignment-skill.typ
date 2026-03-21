#import "../../tkf.typ": *
#tkf-note(id: "notes/ai/2026-03-21-alignment-skill.typ", title: "Using skills to maintain alignment", tags: ("ai"), author: "", date: "2026-03-21", api => [
#let transclude = api.transclude
#let notelink = api.notelink

Assuming you have an AI with some alignment prompt at the start of each conversation.
The issues is that even if the alignment prompt is within the context, no attention may be paid to it.

To a first approximation attention to something can be improved via repetition.

#transclude("./2026-03-21-skills.typ")

The idea then is to use a skill to reiterate the alignment into the context.

e.g. plan.md

```
----
name: plan
description: use to make plans
-----

# Workflow
- Read CLAUDE.md
- Spawn subagents to propose clean plans
- ...
```
])
