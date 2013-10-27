## Custom validation callbacks for Bootstrap.
#  (per https://github.com/thedersen/backbone.validation#callbacks)

_.extend Backbone.Validation.callbacks,
  field: (view, attr) ->
    view.$("##{attr}")

  helpText: (view, attr) ->
    view.$("##{attr} ~ p.text-danger")

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
