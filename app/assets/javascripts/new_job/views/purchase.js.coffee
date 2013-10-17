class NewJob.Views.Purchase extends NewJob.CompositeView
  template: JST['jobs/purchase']
  id: 'purchase'

  initialize: (options) ->
    super(options)
    @model = new NewJob.Models.CreditCard()

  bindings:
    '#number': 'number'
    '#cvv':    'cvv'
    '#month':
      observe: 'month'
      selectOptions:
        collection: 'this._months'
    '#year':
      observe: 'year'
      selectOptions:
        collection: ->
          current = new Date().getFullYear()
          [current..current+15]

  events:
    'click span.make_changes': 'makeChanges'
    'click button.continue':   'continue'

  continue: ->

  makeChanges: ->
    NewJob.router.navigate '', trigger: true

  render: ->
    @$el.html @template()
    @stickit()
    this

  _months: [
      { value: '1', label: '1 - Jan' }
      { value: '2', label: '2 - Feb' }
      { value: '3', label: '3 - Mar' }
      { value: '4', label: '4 - Apr' }
      { value: '5', label: '5 - May' }
      { value: '6', label: '6 - Jun' }
      { value: '7', label: '7 - Jul' }
      { value: '8', label: '8 - Aug' }
      { value: '9', label: '9 - Sep' }
      { value: '10', label: '10 - Oct' }
      { value: '11', label: '11 - Nov' }
      { value: '12', label: '12 - Dec' }
    ]
