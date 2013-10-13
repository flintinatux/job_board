class NewJob.Views.Preview extends NewJob.CompositeView
  template: JST['jobs/preview']
  id: 'preview'

  events:
    'click span.make_changes': 'makeChanges'

  makeChanges: ->
    NewJob.router.navigate '', trigger: true

  render: ->
    @$el.html @template(job: @model.attributes)
    this
