function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 35.6581, lng: 139.7017 },
    zoom: 14,
    mapTypeId: "roadmap",
  });
  // Create the search box and link it to the UI element.
  const input = document.getElementById("pac-input");
  const searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  // Bias the SearchBox results towards current map's viewport.
  map.addListener("bounds_changed", () => {
    searchBox.setBounds(map.getBounds());
  });
  let markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener("places_changed", () => {
    const places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }
    // Clear out the old markers.
    markers.forEach((marker) => {
      marker.setMap(null);
    });
    markers = [];
    // For each place, get the icon, name and location.
    const bounds = new google.maps.LatLngBounds();
    for (i = 0; i < places.length; i++) {
      if (!places[i].geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map,
        title: places[i].name, // 名称
        position: places[i].geometry.location, // 緯度軽度
        address: places[i].formatted_address, // 住所
      })
      const contentString =
        `<div id="ababab">` +
          `<p>${ marker.title }</p>` +
          `<p>${ marker.address }</p>` +
          `<input type="button" value="目的地に設定" id="addplace">` +
        `</div>`;
      markers.push(
        new google.maps.Marker({marker})
      );
      attachInfoWindow(marker, places, contentString, i);

      if (places[i].geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(places[i].geometry.viewport);
      } else {
        bounds.extend(places[i].geometry.location);
      }
    };
    map.fitBounds(bounds);
  });
  var currentInfoWindow = null;
  function attachInfoWindow(marker, places, contentString, n) {
    var infowindow = new google.maps.InfoWindow({
      content: contentString,
    });
    marker.addListener("click", () => {
      if (currentInfoWindow) {
        currentInfoWindow.close();
      }
      infowindow.open(marker.get("map"), marker);
      currentInfoWindow = infowindow;
      infowindow.addListener('domready', () => {
        document.getElementById("addplace").addEventListener("click", () => {
          document.getElementById("data-place-name").value = marker.title;
          document.getElementById("data-place-location").value = marker.position;
          document.getElementById("data-place-address").value = marker.address;
        });
      });
    });
  google.maps.event.addListener(map, 'click', function(){
    infowindow.close();
  });
}
}
window.initMap = initMap;
