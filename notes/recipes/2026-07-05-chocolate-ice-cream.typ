#import "../tkf.typ": *
#import "../../runtime/recipe.typ": recipe_card
#tkf-note(id: "recipes/2026-07-05-chocolate-ice-cream.typ", title: "Chocolate Ice Cream", tags: ("recipe",), author: "", date: "2026-07-05", api => [
#let transclude = api.transclude
#let notelink = api.notelink

#let recipe = r => {
  let mixture = r.act(
    [Mix together in a blender],
    r.ing(
      [coconut milk],
      "2 cans",
      [\~600–800 g],
      [15–17% fat, use the highest available],
    ),
    r.ing([golden syrup], "85 g"),
    r.ing([light brown sugar], "150 g"),
    r.ing([cocoa powder], "60 g"),
    r.ing([whiskey], "15 g"),
    r.ing([vanilla extract], "5 g"),
    r.ing([salt], "5 g"),
  )
  let frozen = r.act([Freeze], mixture)
  let churned = r.act([Blitz in an ice cream maker], frozen)
  r.act([Freeze for at least an hour], churned)
}

#recipe_card(recipe)
])
