class App.UsersController extends App.ApplicationController
  @param "email"
  @param "firstName"
  @param "lastName"

  index: ->
    App.User.all (error, @users) =>
      @render "index"
    
  new: ->
    @user = new App.User
    @render "new"
    
  create: ->
    App.User.create @params.user, (error, @user) =>
      if error
        @redirectTo "new"
      else
        @render 'show'
    
  show:  ->
    App.User.find @params.id, (error, @user) =>
      if @user
        @posts = {}
        @user.posts().all (error, @posts) =>
          @render "show"
      else
        @redirectTo "index"
    
  edit: ->
    App.User.find @params.id, (error, @user) =>
      if @user
        @render "edit"
      else
        @redirectTo "index"
      
  update: ->
    App.User.find @params.id, (error, @user) =>
      if error
        @redirectTo "edit"
      else
        @user.updateAttributes @params.user, (error) =>
          @render 'show'
    
  destroy: ->
    App.User.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"