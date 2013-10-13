class NewJob.Models.Flash extends Backbone.Model
  defaults:
    type:     'info'
    message:  'test message'
    shown:    false

  danger: (message) ->
    @set type: 'danger', message: message, shown: true

  hide: ->
    @set shown: false

  info: (message) ->
    @set type: 'info', message: message, shown: true

  warning: (message) ->
    @set type: 'warning', message: message, shown: true

  success: (message) ->
    @set type: 'success', message: message, shown: true
