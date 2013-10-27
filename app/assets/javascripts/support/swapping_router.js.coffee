class Backbone.SwappingRouter extends Backbone.Router
  swap: (newView) ->
    @currentView?.remove()
    @currentView = newView
    @$el.html @currentView.render().el
    @currentView.swapped()
    this
