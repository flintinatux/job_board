class JobBoard.Views.ActionBar extends Backbone.CompositeView
  template: JST['job_board/action_bar']

  render: ->
    @$el.html @template()
    this
