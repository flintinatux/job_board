class JobBoard.Views.Index extends Backbone.CompositeView
  template: JST['job_board/index']
  id: 'index'

  render: ->
    @$el.html @template()
    @renderChild new JobBoard.Views.ActionBar  el: @$('#action_bar')
    @renderChild new JobBoard.Views.Categories el: @$('#categories')
    this
