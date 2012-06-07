@title = "Editing Post"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @post.toLabel()