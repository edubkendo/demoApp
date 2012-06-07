class App.Post extends Tower.Model
  @field "title", type: "String"
  @field "body", type: "String"
  @field "userId", type: "Integer"

  @belongsTo "user"

  @validates 'title', presence: true

  @timestamps()
