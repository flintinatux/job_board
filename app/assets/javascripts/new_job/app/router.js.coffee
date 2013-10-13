class NewJob.Router extends Backbone.Router
  initialize: ->
    super()
    @$el = $('#jobs')

  routes:
    '':         'create'
    'preview':  'preview'
    'purchase': 'purchase'

  cleanPage: ->
    NewJob.flash.hide()
    $(document).scrollTop 0

  create: ->
    @cleanPage()
    NewJob.progress.set step: 'create'
    @swap new NewJob.Views.Create model: NewJob.job

  preview: ->
    @cleanPage()
    NewJob.progress.set step: 'preview'
    @swap new NewJob.Views.Preview model: NewJob.job

  purchase: ->

  swap: (newView) ->
    @currentView?.remove()
    @currentView = newView
    @$el.html @currentView.render().el
    @currentView.swapped()
    this
