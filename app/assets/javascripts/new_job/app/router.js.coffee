class NewJob.Router extends Backbone.SwappingRouter
  initialize: ->
    super()
    @$el = $('#new_job')

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
    @swap new NewJob.Views.Create()

  preview: ->
    @cleanPage()
    NewJob.progress.set step: 'preview'
    @swap new NewJob.Views.Preview()

  purchase: ->
    @cleanPage()
    NewJob.progress.set step: 'purchase'
    @swap new NewJob.Views.Purchase()
