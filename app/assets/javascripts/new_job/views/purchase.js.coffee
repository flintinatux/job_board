class NewJob.Views.Purchase extends NewJob.CompositeView
  template: JST['jobs/purchase']
  id: 'purchase'

  initialize: (options) ->
    super(options)
    @model = NewJob.job

  render: ->
    @$el.html @template()
    this
