# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.channel-holder').html("Current channel:" + " " + sessionStorage.sNrChannel)

  initializeMap = () ->
    mapCanvas = $('.map-container')[0]
    mapOptions =
      center: new google.maps.LatLng(44.5403, -78.5463)
      zoom: 18
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(mapCanvas, mapOptions)

    return

  initializeMap()
