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

## Add custom validation callbacks for Bootstrap.
#  (per https://github.com/thedersen/backbone.validation#callbacks)

_.extend Backbone.Validation.callbacks,
  elem: (view, attr) ->
    view.$("[name=#{attr}]")

  text: (view, attr) ->
    view.$("[name=#{attr}] ~ p.text-danger")

  valid: (view, attr, selector) ->
    @elem(view, attr).closest('.form-group').removeClass 'has-error'
    @text(view, attr).remove()

  invalid: (view, attr, error, selector) ->
    @elem(view, attr).closest('.form-group').addClass 'has-error'
    @elem(view, attr).after("<p class='text-danger'>#{error}</p>") unless @text(view, attr).length > 0

## Now get ready!

@NewJob =
  Concerns:     {}
  Models:       {}
  Collections:  {}
  Views:        {}

  initialize: ->
    @$el = $('#jobs')
    @job = new NewJob.Models.Job()
    @router = new NewJob.Router()
    Backbone.history.start pushState: true, root: '/jobs/new'

$(document).on 'ready page:change', ->
  NewJob.initialize()
