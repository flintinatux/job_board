class NewJob.Views.Create extends Backbone.CompositeView
  template: JST['new_job/create']
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
    'click button.continue': 'continue'

  continue: ->
    unless @model.validate()
      NewJob.router.navigate 'preview', trigger: true
    else
      NewJob.flash.danger "Please fix the errors below before continuing."
      $(document).scrollTop 0

  remove: ->
    Backbone.Validation.unbind this
    super()

  render: ->
    @$el.html @template()
    @stickit()
    Backbone.Validation.bind this
    this
