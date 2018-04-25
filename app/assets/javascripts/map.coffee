jQuery ->
  markersArray = []
  lat_field = $('#task_latitude')
  lng_field = $('#task_longitude')

  window.initMap = ->
    if $('#map').size() > 0
      map = new google.maps.Map document.getElementById('map'), {
        center: {lat: 10.800900, lng: 106.650511}
        zoom: 12
      }

      map.addListener 'click', (e) ->
        placeMarkerAndPanTo e.latLng, map
        updateFields e.latLng

      $('#find-on-map').click (e) ->
        e.preventDefault()
        placeMarkerAndPanTo {
          lat: parseInt lat_field.val(), 10
          lng: parseInt lng_field.val(), 10
        }, map

    if $('#show-map').size() > 0
      lat_val = parseFloat($('#show_latitude').val())
      lng_val = parseFloat($('#show_longitude').val())
      staff_email = $('#show_staff_email').val()
      note_val = $('#show_note').val()
      date_val = $('#show_date').val()
      show_position  = {lat: lat_val, lng: lng_val}

      show_map = new google.maps.Map document.getElementById('show-map'), {
        center: show_position
        zoom: 12
      }

      contentString =
        '<div><b>Date:  </b>' + date_val    + '</div>' +
        '<div><b>Staff: </b>' + staff_email + '</div>' +
        '<div><b>Note:  </b>' + note_val    + '</div>'

      infowindow = new google.maps.InfoWindow({
        content: contentString
      })

      marker = new google.maps.Marker
        position: show_position
        map: show_map
        title: staff_email + ' - ' + note_val
        animation: google.maps.Animation.DROP

      window.addEventListener 'load', (e) ->
        infowindow.open show_map, marker

      marker.addListener 'click', (e) ->
        infowindow.open show_map, marker

  placeMarkerAndPanTo = (latLng, map) ->
    markersArray.pop().setMap(null) while(markersArray.length)
    marker = new google.maps.Marker
      position: latLng
      map: map

    map.panTo latLng
    markersArray.push marker

  updateFields = (latLng) ->
    lat_field.val latLng.lat()
    lng_field.val latLng.lng()
