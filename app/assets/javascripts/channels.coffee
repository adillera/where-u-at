# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#join-channel').on 'click', (e) ->
    e.preventDefault()

    channel = $('#channel')
    value = channel.val()

    if value == "" || value == null
      alert 'We need a channel to continue'
    else
      sessionStorage.sNrChannel = value

      window.location = '/maps'

    return
