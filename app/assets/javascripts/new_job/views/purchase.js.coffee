class NewJob.Views.Purchase extends NewJob.CompositeView
  template: JST['jobs/purchase']
  id: 'purchase'

  initialize: (options) ->
    super(options)
    @model = NewJob.job

  events:
    'click span.make_changes': 'makeChanges'
    'click button.continue':   'continue'

  continue: ->

  makeChanges: ->
    NewJob.router.navigate '', trigger: true

  render: ->
    @$el.html @template()
    this
