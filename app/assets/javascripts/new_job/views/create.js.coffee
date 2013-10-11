class NewJob.Views.Create extends NewJob.CompositeView
  template: JST['jobs/create']
  id: 'create'

  bindings:
    '#title':         'title'
    '#category_id':
      observe: 'category_id'
      selectOptions:
        collection: 'CurrentBoard.categories'
        labelPath:  'name'
        valuePath:  'id'
    '#location':      'location'
    '#description':   'description'
    '#instructions':  'instructions'
    '#highlight':     'highlight'
    '#company':       'company'
    '#url':           'url'
    '#email':         'email'

  events:
    'submit form': 'submit'

  render: ->
    @$el.html @template(job: @model.attributes)
    @stickit()
    Backbone.Validation.bind this
    this

  submit: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @model.validate()
