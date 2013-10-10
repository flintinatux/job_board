class NewJob.Router extends Backbone.Router
  initialize: ->
    super()
    @$el = $('#jobs')

  routes:
    '':         'create'
    'preview':  'preview'
    'purchase': 'purchase'

  create: ->
    @swap new NewJob.Views.Create model: NewJob.job

  preview: ->

  purchase: ->

  swap: (newView) ->
    @currentView?.remove()
    @currentView = newView
    @$el.html @currentView.render().el
    @currentView.swapped()
    this
