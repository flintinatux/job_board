class JobBoard.Router extends Backbone.SwappingRouter
  initialize: ->
    super()
    @$el = $('#job_board')

  routes:
    '':         'index'
    'jobs':     'index'

  cleanPage: ->
    $(document).scrollTop 0

  index: ->
    @cleanPage()
    @swap new JobBoard.Views.Index()
