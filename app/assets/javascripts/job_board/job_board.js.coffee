## Now get ready!

@JobBoard =
  Concerns:     {}
  Models:       {}
  Collections:  {}
  Views:        {}

  initialize: ->
    @search = new JobBoard.Models.Search()
    @router = new JobBoard.Router()

    Backbone.history.start pushState: true

$(document).ready ->
  JobBoard.initialize()
