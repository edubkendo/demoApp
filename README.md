# (Tower) on Rails Tutorial: second application

This is the demo application for 
[*Ruby on Rails Tutorial: Learn Rails by Example*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com/). 

However, instead of using Ruby on Rails, I am following along but using Coffeescript, Node,
and particularly, the [*Tower.js*](http://towerjs.org/) framework, which was modeled quite closely on rails. It is my plan to not only learn Tower by doing so, but also to document the differences for those following in my footsteps. So far:

See https://github.com/edubkendo/firstApp for how I worked through the first chapter of the book, which includes information on getting a Tower.js app running on [Heroku](http://www.heroku.com/).

## Setup

```
tower new demoApp

cd demoApp/

npm install .

git init

git add .

git commit -m "Initial commit"

git remote add origin git@github.com:username/demoApp.git

git push -u origin master

git checkout -b "Scaffolding"

```

So far only minor changes, all of which have been discussed in the previous app.

```
tower generate scaffold User email:string firstName:string lastName:string hasMany:posts
```
Here we have a couple of extra fields from the User's scaffold Hartl uses in the tutorial, only because this follows the example given in the Towerjs documentation. This is unimportant. 

However, *we include the 'hasMany:posts' relationship in the commandline instruction*, and this is important.

Initially, I thought that "cake db:seed" was the Tower equivalent of rake db:migrate, however it turns out that at least at this point in the book, this is totally unnecessary. We can skip over these migration steps.

```
tower server -e development
```

Check http://localhost:3000 and verify that your app is running, and that you can click on the users link and add, edit and delete users from the database.  If you stop the server, close the webpage, then restart it and reopen it, you should see that the users you created were persisted.

```
tower generate scaffold Post title:string body:text userId:integer belongsTo:user
```

(Again, note that we specify the relationship here, within the generate command).

## hasMany/belongsTo

At this point we need to modify some files to get the relationships between the two resources working.  Because calls to the database are asynchronous in Node, we have to create callbacks in order to gain access to the resources, unlike in the Rails tutorial where it works slightly more simply.

First, we edit the Users Controller in app/controllers/usersController.coffee.  After uncommenting the various actions, we need to change the generic variables being sent to the templates to match what the templates are actually using. Check carefully, make sure you change both the arguements and local variables to match what I have in my file. Also, in the create and update actions, after the user is created or changed, we need to 'render' the page instead of redirectTo, otherwise nothing will happen. Then, in the 'show' action we'll add a callback which will let us view posts that have been linked to the user.  Like so:

```coffeescript
  show:  ->
    App.User.find @params.id, (error, @user) =>
      if @user
        @posts = {}
        @user.posts().all (error, @posts) =>
          @render "show"
      else
        @redirectTo "index"
```
(Please take a look at the file for the other changes.) Notice we use the bound-function '=>', otherwise the context will be wrong when we call @render and it won't be able to find the 'render' method. Also, notice that the lookup for posts, as a relationship, is called on a method, not a property. So be sure to include the parenthesis.

Now we need to change the 'show' template so that it can actually display this information for us. This is located at app/views/user/show.coffee. Here we add a simple loop to the CoffeeKup template that cycles through any posts returned by our callback and renders them.

```coffeescript
@title = "User #{@user.toLabel()}"

dl class: "content", ->
  dt "Email:"
  dd @user.get("email")
  dt "First name:"
  dd @user.get("firstName")
  dt "Last name:"
  dd @user.get("lastName")
if @posts then for post in @posts
  dt "Title"
  dd post.get("title")
  dt "Body"
  dd post.get("body")
```

Re-start your server and visit your page again, make sure you've added at least one user, and visit that users show page. Unlike the Rails example in the tutorial, in this case the userId we need is not a simple "1" or "2" but a rather large Id number.  It will be the string of numbers and letters (appears to be hexadecimal) at the end of the URI.  Copy this and visit your posts page (or microposts if you followed Hartl's tutorial more closely), now paste the userId into the userId slot at the bottom, add a title and body and submit it. After submitting it (which should take you to that posts show page), visit your users show page again. Your post (and any others you created using this users Id) should be listed beneath the users information!

See http://stackoverflow.com/a/10759697/1200100 for more information on how the hasMany/belongsTo relationship works in Towerjs.

## Validation

To add validation to the post, open app/models/post.coffee and add the @validation like so:

```coffeescript
class App.Post extends Tower.Model
  @field "title", type: "String"
  @field "body", type: "String"
  @field "userId", type: "Integer"

  @belongsTo "user"

  @validates 'title', presence: true

  @timestamps()

```

This will prevent posts without a title from being created. We had to vary this a little bit from Hartl's tutorial because at present there is a bug causing length validations to function incorrectly. Remember to re-start your server and try it out yourself.

## Adding the Flash

I added a module to Tower.Controller that makes it possible to generate flash messages, as Hartl does in his tutorial.  Currently, the pull request is still being reviewed, though I believe it will be merged in sometime very soon.  Before you go to the trouble of trying to do this last section, do a simple check to see if your version of Tower is supporting these Flash messages.  Check the directory demoApp/app/views/shared for the file _flash.coffee .  If Towerjs created this for you, then the following should work.  First, we have to modify the Posts Controller like we did the Users Controller earlier, so check the file for how to do that.  Then to add the flash, we set our create action to look like so:

```coffeescript
  create: ->
    App.Post.create @params.post, (error, @post) =>
      if (k for own k, message of @post.errors).length isnt 0
        @flash 'error', message
        @render "new"
      else
        @render "show"  
```

Then re-start your server and attempt to create a post without a title. What you get should look like this:

![Flash Message for Post Without Title](https://github.com/edubkendo/demoApp/raw/master/screenshots/flashScreenshot.png "Flash Message")

For more information about using flash messages in Towerjs, please see [*Flash Messages on the Towerjs Wiki*](https://github.com/edubkendo/flashMessages/blob/master/flash.md) .