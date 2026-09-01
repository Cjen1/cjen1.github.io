#import "../notes/tkf.typ": recipe_card

#let example(name, recipe) = html.elem("recipe-example", attrs: (data-name: name))[
  #recipe_card(recipe)
]

#let lone-ingredient = r => r.ing([flour], "100g", [bread flour], [plus dusting])

#let zero-input-action = r => r.act([Preheat the oven])

#let flat-mix = r => r.act(
  [Mix],
  r.ing([flour], "100 g"),
  r.ing([water], "60   g"),
  r.ing([salt], "?"),
)

#let unary-chain = r => {
  let dough = r.act([Mix], r.ing([flour], "100 g"))
  let rested = r.act([Wait overnight], dough)
  r.act([Bake], rested)
}

#let uneven-bread = r => {
  let poolish = r.act(
    [Mix],
    r.ing([flour], "100 g"),
    r.ing([yeast], "6 g"),
    r.ing([water], "100 g"),
  )
  let fermented-poolish = r.act([Wait overnight], poolish)
  r.act(
    [Mix],
    fermented-poolish,
    r.ing([salt], "11 g"),
    r.ing([flour], "400 g"),
    r.ing([water], "260 g"),
  )
}

#let sibling-branches = r => {
  let starter = r.act([Mix starter], r.ing([flour], "50 g"), r.ing([water], "50 g"))
  let filling = r.act([Cook filling], r.ing([apple], "2"), r.ing([sugar], "20 g"))
  r.act([Assemble], r.act([Rest], starter), filling)
}

#let reused-value = r => {
  let sauce = r.act([Mix sauce], r.ing([tomato], "100 g"))
  r.act([Combine], sauce, sauce)
}

#let markup-content = r => r.act(
  [Fold *gently*],
  r.ing([bread *flour*], "100g", [_for dusting_]),
)

#example("lone-ingredient", lone-ingredient)
#example("zero-input-action", zero-input-action)
#example("flat-mix", flat-mix)
#example("unary-chain", unary-chain)
#example("uneven-bread", uneven-bread)
#example("sibling-branches", sibling-branches)
#example("reused-value", reused-value)
#example("markup-content", markup-content)
