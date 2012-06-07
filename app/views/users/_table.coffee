tableFor "users", (t) ->
  t.head ->
    t.row ->
      t.header "email", sort: true
      t.header "firstName", sort: true
      t.header "lastName", sort: true
  t.body ->
    for user in @users
      t.row class: "user", "data-id": user.get('id').toString(), ->
        t.cell -> user.get("email")
        t.cell -> user.get("firstName")
        t.cell -> user.get("lastName")
        t.cell -> 
          linkTo 'Show', urlFor(user)
          span "|"
          linkTo 'Edit', urlFor(user, action: "edit")
          span "|"
          linkTo 'Destroy', urlFor(user), "data-method": "delete"
  t.foot ->
    t.row ->
      t.cell colspan: 6, ->
        linkTo 'New User', urlFor(App.User, action: "new")

