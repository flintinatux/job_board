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

## Custom validation callbacks for Bootstrap.
#  (per https://github.com/thedersen/backbone.validation#callbacks)

_.extend Backbone.Validation.callbacks,
  field: (view, attr) ->
    view.$("[name=#{attr}]")

  helpText: (view, attr) ->
    view.$("[name=#{attr}] ~ p.text-danger")

  valid: (view, attr, selector) ->
    @field(view, attr).closest('.form-group').removeClass 'has-error'
    @helpText(view, attr).remove()

  invalid: (view, attr, error, selector) ->
    @field(view, attr).closest('.form-group').addClass 'has-error'
    @field(view, attr).after("<p class='text-danger'>#{error}</p>") unless @helpText(view, attr).length > 0

## Now get ready!

@NewJob =
  Concerns:     {}
  Models:       {}
  Collections:  {}
  Views:        {}

  initialize: ->
    @flash    = new NewJob.Models.Flash()
    @job      = new NewJob.Models.Job()
    @progress = new NewJob.Models.Progress()
    @router   = new NewJob.Router()

    new NewJob.Views.Flash el: $('#flash_messages')
    new NewJob.Views.Progress el: $('#header')

    Backbone.history.start pushState: true, root: '/jobs/new'

$(document).ready ->
  NewJob.initialize()
