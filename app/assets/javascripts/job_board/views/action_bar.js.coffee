class JobBoard.Views.ActionBar extends Backbone.CompositeView
  template: JST['job_board/action_bar']

  initialize: (options) ->
    super(options)
    @model = JobBoard.search

  bindings:
    '#query': 'query'

  render: ->
    @$el.html @template()
    @stickit()
    this
