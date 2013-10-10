## Upgrade Backbone to use concerns!
#  (inspired by http://arcturo.github.io/library/coffeescript/03_classes.html)

ClassMethods =
  include: (obj) ->
    for key, value of obj when key isnt 'included'
      @::[key] = value
    object.included?.apply(@)
    this

  addInitializer: (initializer) ->
    @::_initializers ||= []
    @::_initializers.push initializer

ObjectMethods =
  initialize: ->
    @runInitializers arguments

  runInitializers: (args) ->
    _.each @_initializers, (initializer) =>
      initializer.apply this, args

Backbone.Model      = Backbone.Model.extend       ObjectMethods, ClassMethods
Backbone.Collection = Backbone.Collection.extend  ObjectMethods, ClassMethods
Backbone.View       = Backbone.View.extend        ObjectMethods, ClassMethods
Backbone.Router     = Backbone.Router.extend      ObjectMethods, ClassMethods

@NewJob =
  Concerns:     {}
  Models:       {}
  Collections:  {}
  Views:        {}
  Routers:      {}

  initialize: ->
    @$el = $('#jobs')
    @job = new NewJob.Models.Job()
    @swap new NewJob.Views.Create model: @job

  swap: (newView) ->
    @currentView.remove() if @currentView
    @currentView = newView
    @$el.html @currentView.render().el
    @currentView.swapped()
    this

$(document).on 'ready page:change', ->
  NewJob.initialize()
