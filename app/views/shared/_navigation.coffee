linkTo t("title"), "/", class: "brand"

div class: "nav-collapse", ->
  ul class: "nav", ->
    navItem t("links.posts"), urlFor(App.Post)
    navItem t("links.users"), urlFor(App.User)
  ul class: "nav pull-right", ->
    li class: "dropdown", ->
      linkTo t("links.docs"), "#", class: "dropdown-toggle", "data-toggle": "dropdown", ->
        b class: "caret"
      ul class: "dropdown-menu", ->
        li ->
          linkTo "Tower.js", "http://towerjs.org"