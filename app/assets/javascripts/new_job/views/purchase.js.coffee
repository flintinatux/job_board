class NewJob.Views.Purchase extends NewJob.CompositeView
  template: JST['jobs/purchase']
  id: 'purchase'

  initialize: (options) ->
    super(options)
    @model = new NewJob.Models.CreditCard()
    @listenTo @model, 'change:number', @identifyCard

  bindings:
    '#number':
      observe: 'number'
      initialize: ($el) -> $el.payment 'formatCardNumber'
    '#cvv':
      observe: 'cvv'
      initialize: ($el) -> $el.payment 'formatCardCVC'
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
    '#postal_code': 'postal_code'

  events:
    'click span.make_changes': 'makeChanges'
    'submit form': 'submit'

  identifyCard: (model, number) ->
    type = switch
      when number.match /^5[1-5]/           then 'mastercard'
      when number.match /^4/                then 'visa'
      when number.match /^3(4|7)/           then 'american_express'
      when number.match /^6011/             then 'discover'
      when number.match /^(30[0-5]|36|38)/  then 'diners_club'
      when number.match /^(3|2131|1800)/    then 'jcb'
      else 'none'
    @$('.card').each -> $(this).toggleClass 'identified', $(this).hasClass type

  makeChanges: ->
    NewJob.router.navigate '', trigger: true

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
      # @$('button.continue').attr 'disabled', true
      # encrypt and submit the form
    else
      # don't submit

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
