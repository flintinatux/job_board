class NewJob.Views.Preview extends Backbone.CompositeView
  template: JST['new_job/preview']
  id: 'preview'

  initialize: (options) ->
    super(options)
    @model = NewJob.job

  events:
    'click span.make_changes': 'makeChanges'
    'click button.continue':   'continue'

  continue: ->
    NewJob.router.navigate 'purchase', trigger: true

  makeChanges: ->
    NewJob.router.navigate '', trigger: true

  render: ->
    @$el.html @template(job: @model.attributes)
    this
