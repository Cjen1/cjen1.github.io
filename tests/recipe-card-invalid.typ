#import "../runtime/recipe.typ": recipe_card

#let recipe-case = sys.inputs.at("recipe-case")

#let recipe = if recipe-case == "invalid-root" {
  _ => [not a recipe node]
} else if recipe-case == "invalid-input" {
  r => r.act([Mix], [not a recipe node])
} else if recipe-case == "named-action-argument" {
  r => r.act([Mix], note: [not supported])
} else if recipe-case == "named-ingredient-argument" {
  r => r.ing([flour], "100 g", detail: [not supported])
} else if recipe-case == "invalid-quantity" {
  r => r.ing([flour], "one handful")
} else if recipe-case == "non-string-quantity" {
  r => r.ing([flour], 100)
} else {
  panic("unknown recipe test case")
}

#recipe_card(recipe)
