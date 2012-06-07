formFor @post, (f) ->
  f.fieldset (fields) ->
    fields.field "title", as: "string"
    fields.field "body", as: "string"
    fields.field "userId", as: "string"
  f.fieldset (fields) ->
    fields.submit "Submit"
