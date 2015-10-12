# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#join-channel').on 'click', (e) ->
    e.preventDefault()

    handle = $('#handle')
    hValue = handle.val()
    channel = $('#channel')
    cValue = channel.val()

    if hValue == "" || hValue == null
      alert 'We need a handle to continue'
    else
      sessionStorage.sNrHandle = hValue

    if cValue == "" || cValue == null
      alert 'We need a channel to continue'
    else
      sessionStorage.sNrChannel = cValue

    if hValue && cValue
      window.location = '/maps'

    return
