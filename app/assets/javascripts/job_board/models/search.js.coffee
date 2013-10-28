class JobBoard.Models.Search extends Backbone.Model
  defaults:
    query: ''

  clear: ->
    @set 'query', ''
