class App.PostsController extends App.ApplicationController
  @param "title"
  @param "body"
  @param "userId"

  index: ->
    App.Post.all (error, @posts) =>
      @render "index"
    
  new: ->
    @post = new App.Post
    @render "new"
    
  create: ->
    App.Post.create @params.post, (error, @post) =>
      if error
        @redirectTo "new"
      else
        @render 'show'
    
  show:  ->
    App.Post.find @params.id, (error, @post) =>
      if @post
        @render "show"
      else
        @redirectTo "index"
    
  edit: ->
    App.Post.find @params.id, (error, @post) =>
      if @post
        @render "edit"
      else
        @redirectTo "index"
      
  update: ->
    App.Post.find @params.id, (error, @post) =>
      if error
        @redirectTo "edit"
      else
        @post.updateAttributes @params.post, (error) =>
          @render 'show'
    
  destroy: ->
    App.Post.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"
