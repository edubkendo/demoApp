class App.User extends Tower.Model
  @field "email", type: "String"
  @field "firstName", type: "String"
  @field "lastName", type: "String"

  @hasMany "posts"

  @timestamps()
