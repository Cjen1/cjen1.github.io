#import "../tkf.typ": *
#import "../../runtime/recipe.typ": recipe_card
#tkf-note(id: "recipes/2026-06-17-chicken-paella.typ", title: "Chicken Paella", tags: ("recipe",), author: "", date: "2026-06-17", api => [
#let transclude = api.transclude
#let notelink = api.notelink

#let recipe = r => {
  let hards = r.act(
    [Sweat the hards],
    r.ing([carrots], "2"),
    r.ing([celery], "5 sticks", [\~25 cm total]),
  )

  let softs = r.act(
    [Add the softs],
    hards,
    r.ing([red onion], "1"),
    r.ing([tomatoes], "1 tin"),
    r.ing([mushrooms], "?"),
    r.ing([peppers], "?"),
  )

  let base = r.act(
    [Deglaze with stock],
    softs,
    r.ing([chicken stock], "500 ml"),
  )

  let seasoned = r.act(
    [Season until the stock tastes strongly salty],
    base,
    r.ing([smoked paprika], "2.5 tsp"),
    r.ing([turmeric], "0.75 tsp"),
    r.ing([black pepper], "0.5 tsp"),
    r.ing([salt], "3 tsp", [fine salt to start]),
    r.ing([chilli or cayenne], "0.25 tsp", [optional]),
  )

  let toppings = r.act(
    [Fry the sausage and other toppings],
    r.ing(
      [chorizo],
      "?",
      [soft sausage, such as Sainsbury's chorizo-style sausage],
      [or Plant Pioneers chorizo-style shroomdogs],
    ),
    r.ing([prawns], "?", [optional]),
    r.ing([chicken], "?", [optional]),
  )

  let rice-pan = r.act(
    [Mix everything with the rice in a large flat pan],
    seasoned,
    toppings,
    r.ing([rice], "500 g"),
  )
  let watered = r.act([Add water], rice-pan, r.ing([water], "400 ml"))
  let lidded = r.act(
    [Simmer with the lid until the rice is al dente, about 10 minutes],
    watered,
  )
  let reduced = r.act([Simmer uncovered until mostly dry], lidded)
  let transferred = r.act([Transfer to a 160°C oven], reduced)
  let crisped = r.act([Cook until the rice is mostly dry and crispy], transferred)
  let crusted = r.act(
    [Cook on the stove over medium-high heat for 3 minutes to form a crust],
    crisped,
  )
  r.act(
    [Serve with lemon or lime and a dusting of salt],
    crusted,
    r.ing([lemon or lime], "?"),
  )
}

#recipe_card(recipe)
])
