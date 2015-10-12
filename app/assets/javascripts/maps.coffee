# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.channel-holder').html("Current channel:" + " " + sessionStorage.sNrChannel + " | " + "Current handle:" + " " + sessionStorage.sNrHandle)

  geoLoc = null
  latLng = null
  map = null
  eventSource = null

  initializeChannel = () ->
    geoLoc = navigator.geolocation

    if geoLoc
      geoLoc.watchPosition(getPosition)

      renderMap()

      startEventSource()
    else
      alert 'Geolocation is not supported by this browser.'

    return

  getPosition = (position) ->
    latLng = {
      lat: position.coords.latitude
      lng: position.coords.longitude
    }

    jQuery.post('/maps/publish', { latLng: latLng, channel: sessionStorage.sNrChannel, handle: sessionStorage.sNrHandle })

    return

  renderMap = () ->
    geoLoc.getCurrentPosition (p) ->
      mapCanvas = $('.map-container')[0]
      mapOptions =
        center: new google.maps.LatLng(p.coords.latitude, p.coords.longitude)
        zoom: 18
        mapTypeId: google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(mapCanvas, mapOptions)

    return

  renderMarker = (latLng, map, handle) ->
    infoWindow = new google.maps.InfoWindow(
      content: handle
    )

    marker = new google.maps.Marker
      position: new google.maps.LatLng(latLng.lat, latLng.lng)
      map: map

    marker.addListener 'click', () ->
      infoWindow.open(map, marker)

    return

  startEventSource = () ->
    eventSource = new EventSource('/maps/feed?channel=' + sessionStorage.sNrChannel)

    eventSource.addEventListener('message', (e) ->
      resp = JSON.parse(e.data)
      latLng = resp.lat_lng
      handle = resp.handle

      renderMarker(latLng, map, handle)
    , false)

    return


  initializeChannel()


