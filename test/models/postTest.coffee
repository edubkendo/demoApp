post = null

describe "App.Post", ->
  describe "fields", ->
    beforeEach (done) ->
      post = new App.Post
        title: "A title"
        body: "A body"
        userId: "A userId"
        
      done()  

    test "title", ->
      assert.ok post.get("title")

    test "body", ->
      assert.ok post.get("body")

    test "userId", ->
      assert.ok post.get("userId")

  describe "relations", ->
  
