class JobBoard.Views.Category extends Backbone.CompositeView
  className: 'category'
  template:  JST['job_board/category']

  initialize: (options) ->
    super(options)
    @listenTo @model, 'remove', @remove

  bindings:
    '.name':
      observe: 'name'
      onGet: (name) -> "#{name} Jobs"
    '.updated_at':
      attributes: [{
        name: 'datetime'
        observe: 'updated_at'
      }]

  render: ->
    @$el.html @template()
    @stickit()
    @$('time.timeago').timeago()
    this
