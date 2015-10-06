# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.channel-holder').html("Current channel:" + " " + sessionStorage.sNrChannel)

  initializeMap = () ->
    latLng = new google.maps.LatLng(44.5403, -78.5463)
    mapCanvas = $('.map-container')[0]
    mapOptions =
      center: latLng
      zoom: 18
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(mapCanvas, mapOptions)

    marker = new google.maps.Marker
      position: latLng
      map: map
      title: 'wee'

    return

  initializeMap()
