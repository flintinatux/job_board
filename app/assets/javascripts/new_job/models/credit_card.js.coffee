class NewJob.Models.CreditCard extends Backbone.Model
  defaults:
    number: '4111111111111111'
    cvv:    '111'
    month:  '11'
    year:   '2015'
    zip_code: '30120'

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
    zip_code:
      required: true
      msg: 'Please enter your zip code.'
