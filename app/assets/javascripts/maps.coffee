# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.channel-holder').html("Current channel:" + " " + sessionStorage.sNrChannel)

  latLng = null
  map = null
  eventSource = null

  initializeChannel = () ->
    geoLoc = navigator.geolocation

    if geoLoc
      geoLoc.getCurrentPosition(getPosition)
    else
      alert 'Geolocation is not supported by this browser.'

    return

  getPosition = (position) ->
    latLng = new google.maps.LatLng(
      position.coords.latitude
    , position.coords.longitude
    )

    renderMap(latLng)

    return

  renderMap = (latLng) ->
    mapCanvas = $('.map-container')[0]
    mapOptions =
      center: latLng
      zoom: 18
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(mapCanvas, mapOptions)

    renderMarker(latLng, map)

    return

  renderMarker = (latLng, map) ->
    new google.maps.Marker
      position: latLng
      map: map
      label: 'A'

    startEventSource()

    return

  startEventSource = () ->
    eventSource = new EventSource('/maps/feed')

    eventSource.addEventListener('message', (e) ->
      console.log(e.data)
      console.log(e)
    , false)


  initializeChannel()


