formFor @user, (f) ->
  f.fieldset (fields) ->
    fields.field "email", as: "string"
    fields.field "firstName", as: "string"
    fields.field "lastName", as: "string"
  f.fieldset (fields) ->
    fields.submit "Submit"
