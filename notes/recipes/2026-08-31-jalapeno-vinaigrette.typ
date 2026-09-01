#import "../tkf.typ": *
#import "../../runtime/recipe.typ": recipe_card
#tkf-note(id: "recipes/2026-08-31-jalapeno-vinaigrette.typ", title: "Jalapeno Vinaigrette", tags: ("recipe",), author: "Cjen1", date: "2026-08-31", api => [
#let transclude = api.transclude
#let notelink = api.notelink

#let recipe = r => {
  r.act(
    [Blend until emulsified],
    r.ing([pickled jalapeño slices], "3 tsp"),
    r.ing([scallions], "2"),
    r.ing([garlic], "1 clove"),
    r.ing([lime juice], "3 tbsp", [\~1 lime]),
    r.ing([apple cider vinegar], "1 tsp"),
    r.ing([honey], "0.5 tsp"),
    r.ing([ground cumin], "0.5 tsp"),
    r.ing([ancho chilli paste], "0.5 tsp"),
    r.ing([salt], "1 tsp"),
    r.ing([olive oil], "?", [enough to make an emulsion]),
  )
}

#recipe_card(recipe)
])
