class NewJob.Views.Create extends NewJob.CompositeView
  template: JST['jobs/create']
  id: 'create'

  render: ->
    @$el.html @template(job: @model.attributes)
    this
