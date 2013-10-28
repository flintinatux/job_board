class JobBoard.Views.Categories extends Backbone.CompositeView
  id: 'categories'

  initialize: (options) ->
    super(options)
    @collection ||= new JobBoard.Collections.Categories()
    @listenTo @collection, 'add', @addCategory
    @collection.fetch()

  addCategory: (category) ->
    @$el.append @renderChild(new JobBoard.Views.Category model: category).el
