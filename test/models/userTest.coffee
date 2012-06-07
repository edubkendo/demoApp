user = null

describe "App.User", ->
  describe "fields", ->
    beforeEach (done) ->
      user = new App.User
        email: "A email"
        firstName: "A firstName"
        lastName: "A lastName"
        
      done()  

    test "email", ->
      assert.ok user.get("email")

    test "firstName", ->
      assert.ok user.get("firstName")

    test "lastName", ->
      assert.ok user.get("lastName")

  describe "relations", ->
  
