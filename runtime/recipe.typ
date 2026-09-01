// Recipe DSL constructors. This file is imported as a module so recipe
// closures can use the natural r.ing(...) and r.act(...) call syntax.

#let ing(name, quantity, ..details) = {
  if details.named().len() > 0 {
    panic("recipe ingredients do not accept named arguments")
  }

  (
    recipe_node: true,
    kind: "ingredient",
    name: name,
    quantity: quantity,
    details: details.pos(),
  )
}

#let act(words, ..args) = {
  if args.named().len() > 0 {
    panic("recipe actions do not accept named arguments")
  }

  (
    recipe_node: true,
    kind: "action",
    words: words,
    inputs: args.pos(),
  )
}
