@title = "Editing User"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @user.toLabel()