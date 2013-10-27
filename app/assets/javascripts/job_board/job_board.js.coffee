## Now get ready!

@JobBoard =
  Concerns:     {}
  Models:       {}
  Collections:  {}
  Views:        {}

  initialize: ->
    @router   = new JobBoard.Router()
    Backbone.history.start pushState: true

$(document).ready ->
  JobBoard.initialize()
