class JobBoard.Views.Category extends Backbone.CompositeView
  className: 'category'
  template:  JST['job_board/category']

  initialize: (options) ->
    super(options)
    @listenTo @model, 'remove', @remove

  render: ->
    @$el.html @template @model.attributes
    @$('time.timeago').timeago()
    this
