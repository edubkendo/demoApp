class App.Post extends Tower.Model
  @field "title", type: "String"
  @field "body", type: "String"
  @field "userId", type: "Integer"

  @belongsTo "user"

#  @validates 'body', lte: 140

  # @validates "body", length: { maximum: 140, tooLong: "%{count} characters is the maximum allowed" }

  @timestamps()
