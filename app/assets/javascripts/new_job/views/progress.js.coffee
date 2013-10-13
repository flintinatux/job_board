class NewJob.Views.Progress extends NewJob.CompositeView
  initialize: ->
    @listenTo NewJob.progress, 'change:step', @update

  update: (progress, step) ->
    buttons = @$('button.btn')
    _.each buttons, (button) =>
      current = $(button).hasClass step
      $(button).toggleClass 'btn-default', !current
      $(button).toggleClass 'btn-primary', current
