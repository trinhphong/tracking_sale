jQuery ->
  markersArray = []
  lat_field = $('#outlet_latitude')
  lng_field = $('#outlet_longitude')
  infowindow = null

  window.initMap = ->
    if $('#map').size() > 0
      map = new google.maps.Map document.getElementById('map'), {
        center: {lat: 10.800900, lng: 106.650511}
        zoom: 12
      }

      geocoder = new google.maps.Geocoder();

      document.getElementById('submit-search-map').addEventListener 'click', ->
        geocodeAddress geocoder, map

      map.addListener 'click', (e) ->
        placeMarkerAndPanTo e.latLng, map
        updateFields e.latLng

      $('#find-on-map').click (e) ->
        e.preventDefault()
        placeMarkerAndPanTo {
          lat: parseInt lat_field.val(), 10
          lng: parseInt lng_field.val(), 10
        }, map

    if $('#dashboard-map').size() > 0
      dashboard_map = new google.maps.Map document.getElementById('dashboard-map'), {
        center: {lat: 10.800900, lng: 106.650511}
        zoom: 12
      }

      number_of_tasks = $('#number-of-tasks').val()
      infowindow = new google.maps.InfoWindow()

      for idx in [0..(number_of_tasks - 1)]
        task_id     = $("#hidden-field-task-#{idx} .hidden-task-id").val()
        staff_email = $("#staff-email-#{task_id}").val()
        note        = $("#task-note-#{task_id}").val()
        lat         = parseFloat $("#latitude-#{task_id}").val()
        lon         = parseFloat $("#longitude-#{task_id}").val()
        expect_sale = parseFloat $("#expect-sale-#{task_id}").val()
        actual_sale = parseFloat $("#actual-sale-#{task_id}").val()
        check_in    = $("#check-in-#{task_id}").val()
        check_out   = $("#check-out-#{task_id}").val()

        pinColor = getRandomColor()
        pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor)

        marker = new google.maps.Marker
          position: {lat: lat, lng: lon}
          map: dashboard_map
          title: staff_email + ' - ' + note
          animation: google.maps.Animation.DROP
          icon: pinImage

        google.maps.event.addListener marker, 'click', do (marker, idx) ->
          ->
            task_id     = $("#hidden-field-task-#{idx} .hidden-task-id").val()
            staff_email = $("#staff-email-#{task_id}").val()
            note        = $("#task-note-#{task_id}").val()
            contentString =
              '<div><b>Staff: </b>'     + staff_email + '</div>' +
              '<div><b>Note:  </b>'     + note        + '</div>' +
              '<div><b>Expect: </b>'    + expect_sale + '$</div>' +
              '<div><b>Actual: </b>'    + actual_sale + '$</div>' +
              '<div><b>Check-in: </b>'  + check_in    + '</div>' +
              '<div><b>Check-out: </b>' + check_out   + '</div>'
            infowindow.setContent contentString
            infowindow.open dashboard_map, marker
            return

    if $('#show-map').size() > 0
      show_map = new google.maps.Map document.getElementById('show-map'), {
        center: {lat: 10.800900, lng: 106.650511}
        zoom: 12
      }

      number_of_outlets = $('#number-of-outlets').val()
      infowindow = new google.maps.InfoWindow()

      for idx in [0..(number_of_outlets - 1)]
        outlet_id   = $("#hidden-field-task-outlet-#{idx} .hidden-task-outet-id").val()
        lat_val     = parseFloat $("#outlet-latitude-#{outlet_id}").val()
        lng_val     = parseFloat $("#outlet-longitude-#{outlet_id}").val()

        pinColor = getRandomColor()
        pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor)

        marker = new google.maps.Marker
          position: {lat: lat_val, lng: lng_val}
          map: show_map
          animation: google.maps.Animation.DROP
          icon: pinImage

        google.maps.event.addListener marker, 'click', do (marker, idx) ->
          ->
            outlet_id = $("#hidden-field-task-outlet-#{idx} .hidden-task-outet-id").val()
            address   = $("#outlet-address-#{outlet_id}").val()
            priority  = $("#outlet-priority-#{outlet_id}").val()
            contentString =
              '<div><b>Priority:  </b>'    + priority   + '</div>' +
              '<div><b>Address:  </b>'     + address    + '</div>'
            infowindow.setContent contentString
            infowindow.open show_map, marker
            return

    if $('#show-outlet-map').size() > 0
      lat_val = parseFloat($('#show_latitude').val())
      lng_val = parseFloat($('#show_longitude').val())
      address = $('#address').val()
      show_position  = {lat: lat_val, lng: lng_val}

      outlet_show_map = new google.maps.Map document.getElementById('show-outlet-map'), {
        center: show_position
        zoom: 12
      }

      contentString =
        '<div><b>Address:  </b>' + address + '</div>'

      infowindow = new google.maps.InfoWindow({
        content: contentString
      })

      marker = new google.maps.Marker
        position: show_position
        map: outlet_show_map
        animation: google.maps.Animation.DROP

      window.addEventListener 'load', (e) ->
        infowindow.open outlet_show_map, marker

      marker.addListener 'click', (e) ->
        infowindow.open outlet_show_map, marker

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

  getRandomColor = ->
    letters = '0123456789ABCDEF'.split('')
    color = ''
    i = 0
    while i < 6
      color += letters[Math.round(Math.random() * 15)]
      i++
    color

  geocodeAddress = (geocoder, resultsMap) ->
    address = document.getElementById('outlet_address').value
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == 'OK'
        resultsMap.setCenter results[0].geometry.location
        updateFields(results[0].geometry.location)
        marker = new (google.maps.Marker)(
          map: resultsMap
          position: results[0].geometry.location)
      else
        alert 'Geocode was not successful for the following reason: ' + status

