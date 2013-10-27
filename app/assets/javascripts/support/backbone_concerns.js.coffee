## Upgrade Backbone to use concerns!
#  (inspired by http://arcturo.github.io/library/coffeescript/03_classes.html)

ClassMethods =
  include: (obj) ->
    for key, value of obj when key isnt 'included'
      @::[key] = value
    obj.included?.apply(@)
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
