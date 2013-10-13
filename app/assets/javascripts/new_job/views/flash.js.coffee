class NewJob.Views.Flash extends NewJob.CompositeView
  template: JST['jobs/flash']

  initialize: ->
    super()
    @listenTo NewJob.flash, 'change', @render
    @listenTo NewJob.flash, 'change:shown', @_toggleShow

  events:
    'click .close' : 'hide'

  hide: ->
    NewJob.flash.hide()

  render: ->
    @$el.html @template(NewJob.flash.attributes) if NewJob.flash.get('shown')
    this

  _toggleShow: (model, shown) ->
    @$el.toggle shown
