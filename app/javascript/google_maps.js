var place_name = [];
var place_formatted_address = [];
var place_position = [];

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
    places.forEach((place) => {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      // Create a marker for each place.
      const marker = new google.maps.Marker({
        map,
        title: place.name, // 名称
        position: place.geometry.location, // 緯度軽度
        address: place.formatted_address, // 住所
      })
      place_name = place.name;
      place_formatted_address = place.formatted_address;
      place_position = place.geometry.location;
      const contentString =
        `<div id="ababab">` +
          `<p>${ place_name }</p>` +
          `<p>${ place_formatted_address }</p>` +
          // `<a href="proof_of_days/new"></a><input type="button" value="追加" onclick="addPlace(place_name, place_position)"` +
          `<input type="button" value="目的地に設定" id="addplace">` +
        `</div>`;
      // addPlace(place_name, place_position);

      markers.push(
        new google.maps.Marker({marker})
      );
      attachInfoWindow(marker, contentString);

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
}

function attachInfoWindow(marker, contentString, callback) {
  const place_name2 = marker.title;
  const place_position2 = marker.position;
  const infowindow = new google.maps.InfoWindow({
    content: contentString,
  });
  marker.addListener("click", () => {
    infowindow.open(marker.get("map"), marker)
    infowindow.addListener('domready', () => {
      document.getElementById("addplace").addEventListener("click", () => {
        document.getElementById("data-place-name").value = place_name2;
      });
    });
  });
}
window.initMap = initMap;

// function addPlace(place_name, position) {
//   // var name = place_name;
//   console.log(place_name);
//   document.getElementById("data-place-name").value = place_name;
// }
