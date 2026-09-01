#import "recipe-dsl.typ" as recipe-dsl

// Normalize and validate the string form used by recipe quantities. The
// recipe card preserves unknown quantities and inserts exactly one space
// between a numeric scalar and its unit.
#let recipe-normalize-quantity(quantity) = {
  if type(quantity) != str {
    panic("recipe quantity must be a string")
  }

  let trimmed = quantity.trim()
  if trimmed == "?" {
    "?"
  } else {
    let matched = trimmed.match(regex("^([0-9]+(?:\\.[0-9]+)?)[[:space:]]*(.*)$"))
    if matched == none {
      panic("recipe quantity must be a decimal scalar with an optional unit, or \"?\"")
    }

    let number = matched.captures.at(0)
    let unit = matched.captures.at(1).trim()
    if unit == "" { number } else { number + " " + unit }
  }
}

#let recipe-node-kind(node, invalid-message) = {
  if (
    type(node) != dictionary or
    node.at("recipe_node", default: false) != true or
    (
      node.at("kind", default: none) != "ingredient" and
      node.at("kind", default: none) != "action"
    )
  ) {
    panic(invalid-message)
  }
  node.kind
}

// Validate the expanded recipe tree and return the metadata needed by the
// renderer. Paths identify occurrences, so reusing a value expands it once at
// every input position.
#let recipe-measure(
  node,
  path: "root",
  invalid-message: "recipe action inputs must be ingredient or action nodes",
) = {
  let kind = recipe-node-kind(node, invalid-message)

  if kind == "ingredient" {
    if type(node.name) != content {
      panic("recipe ingredient names must be content")
    }
    if type(node.details) != array or node.details.any(detail => type(detail) != content) {
      panic("recipe ingredient details must be content")
    }

    (
      kind: kind,
      path: path,
      rows: 1,
      depth: 1,
      name: node.name,
      quantity: recipe-normalize-quantity(node.quantity),
      details: node.details,
    )
  } else {
    if type(node.words) != content {
      panic("recipe action words must be content")
    }
    if type(node.inputs) != array {
      panic("recipe action inputs must be ingredient or action nodes")
    }

    let children = ()
    for (index, input) in node.inputs.enumerate() {
      children.push(recipe-measure(
        input,
        path: path + "." + str(index),
      ))
    }

    let rows = if children.len() == 0 {
      1
    } else {
      children.fold(0, (total, child) => total + child.rows)
    }
    let child-depth = children.fold(0, (deepest, child) => calc.max(deepest, child.depth))

    (
      kind: kind,
      path: path,
      rows: rows,
      depth: child-depth + 1,
      words: node.words,
      children: children,
    )
  }
}

#let recipe-gap-cell(levels) = html.elem("td", attrs: (
  class: "recipe-gap",
  colspan: str(levels * 2),
  aria-hidden: "true",
))

#let recipe-ingredient-cells(node) = {
  let name-cell = html.elem("td", attrs: (class: "recipe-ingredient-name-cell"))[
    #html.elem("recipe-ingredient-name")[#node.name]
    #for detail in node.details {
      html.elem("recipe-ingredient-detail")[#detail]
    }
  ]
  let quantity-cell = html.elem("td", attrs: (class: "recipe-ingredient-quantity-cell"))[
    #html.elem("recipe-ingredient-quantity")[#node.quantity]
  ]
  (name-cell, quantity-cell)
}

#let recipe-action-cell(node) = {
  let attrs = (
    class: "recipe-action-cell",
    colspan: "2",
  )
  if node.rows > 1 {
    attrs.insert("rowspan", str(node.rows))
  }
  html.elem("td", attrs: attrs)[
    #html.elem("recipe-action")[#node.words]
  ]
}

// Return an array of rows, where each row is an array of HTML table cells.
// width is measured in two-column dependency levels.
#let recipe-render-node(node, width) = {
  let leading-levels = width - node.depth

  if node.kind == "ingredient" {
    let row = ()
    if leading-levels > 0 {
      row.push(recipe-gap-cell(leading-levels))
    }
    row += recipe-ingredient-cells(node)
    (row,)
  } else if node.children.len() == 0 {
    let row = ()
    if leading-levels > 0 {
      row.push(recipe-gap-cell(leading-levels))
    }
    row.push(recipe-action-cell(node))
    (row,)
  } else {
    let rows = ()
    for child in node.children {
      rows += recipe-render-node(child, width - 1)
    }

    let result = ()
    for (index, row) in rows.enumerate() {
      if index == 0 {
        result.push((..row, recipe-action-cell(node)))
      } else {
        result.push(row)
      }
    }
    result
  }
}

#let recipe-render-row(cells) = html.elem("tr")[
  #for cell in cells { cell }
]

#let recipe_card(recipe) = {
  if type(recipe) != function {
    panic("recipe must return exactly one ingredient or action node")
  }

  let root = recipe(recipe-dsl)
  let tree = recipe-measure(
    root,
    invalid-message: "recipe must return exactly one ingredient or action node",
  )
  let rows = recipe-render-node(tree, tree.depth)

  html.elem("recipe-card")[
    #html.elem("table", attrs: (class: "recipe-card-table"))[
      #html.elem("tbody")[
        #for row in rows { recipe-render-row(row) }
      ]
    ]
  ]
}
