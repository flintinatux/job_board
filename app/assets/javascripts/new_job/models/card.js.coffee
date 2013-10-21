class NewJob.Models.Card extends Backbone.Model
  defaults:
    number: '4111111111111111'
    cvv:    '111'
    month:  '1'
    year:   new Date().getFullYear().toString()
    postal_code: '30120'

  validation:
    number:
      required: true
      fn: (value) ->
        if $.payment.validateCardNumber(value) then null else true
      msg: 'Please enter a valid card number.'
    cvv:
      required: true
      rangeLength: [3,4]
      msg: 'Please enter a valid CVV.'
    postal_code:
      required: true
      msg: 'Please enter your zip code.'

  clean: ->
    @attributes = {}
