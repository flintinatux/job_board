class NewJob.CompositeView extends Backbone.View
  initialize: ->
    super()
    @children = _([])

  renderChild: (child) ->
    child.render()
    @children.push child
    child.parent = this
    this

  remove: ->
    @trigger 'remove'
    super()
    @_removeChildren()
    @_removeFromParent()
    this

  swapped: ->
    @trigger 'swapped'
    this

  _removeChild: (child) ->
    index = @children.indexOf child
    @children.splice index, 1

  _removeChildren: ->
    _.each @children.clone(), (child) ->
      child.remove()

  _removeFromParent: ->
    @parent._removeChild(this) if @parent
