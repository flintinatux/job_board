class NewJob.Views.Create extends NewJob.CompositeView
  template: JST['jobs/create']
  id: 'create'

  initialize: (options) ->
    super(options)
    @model = NewJob.job

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

  remove: ->
    Backbone.Validation.unbind this
    super()

  render: ->
    @$el.html @template()
    @stickit()
    Backbone.Validation.bind this
    this

  submit: (event) ->
    event.stopPropagation()
    event.preventDefault()
    unless @model.validate()
      NewJob.router.navigate 'preview', trigger: true
    else
      NewJob.flash.danger "Please fix the errors below before continuing."
      $(document).scrollTop 0
