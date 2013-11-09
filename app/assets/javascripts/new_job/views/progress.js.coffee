class NewJob.Views.Progress extends Backbone.CompositeView
  initialize: ->
    @listenTo NewJob.progress, 'change:step', @update

  update: (progress, step) ->
    buttons = @$('.btn')
    _.each buttons, (button) =>
      current = $(button).hasClass step
      $(button).toggleClass 'btn-default', !current
      $(button).toggleClass 'btn-primary', current
