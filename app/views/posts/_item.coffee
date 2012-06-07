li class: "post", ->
  header class: "header", ->
    h3 @post.toLabel()
  dl class: "content", ->
    dt "Title:"
    dd @post.get("title")
    dt "Body:"
    dd @post.get("body")
    dt "User:"
    dd @post.get("userId")
  footer class: "footer", ->
    menu ->
      menuItem "Edit", urlFor(@post, action: "edit")
