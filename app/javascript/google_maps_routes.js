function initMapRoutes() {
  map = new google.maps.Map(document.getElementById("map_routes"), {
    center: { lat: 35.6581, lng: 139.7017 },
    zoom: 14,
    mapId: "roadmap",
    mapTypeControl: false,
    streetViewControl: false,
    fullscreenControl: false,
  });
  let rendererOptions = {
    map: map,
    draggable: true,
    preserveViewport: true
  };
  let directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
  let directionsService = new google.maps.DirectionsService();
  directionsDisplay.setMap(map);
  let request = {
  origin: new google.maps.LatLng(35.6120, 139.3824), // 出発地点
  destination: new google.maps.LatLng(35.6581, 139.7017), // 待ち合わせ場所
  travelMode: google.maps.DirectionsTravelMode.WALKING, // 移動手段
  };
  directionsService.route(request, function(response,status) {
    if (status === google.maps.DirectionsStatus.OK) {
      new google.maps.DirectionsRenderer({
        map: map,
        directions: response,
      });
    //   debugger;
      let leg = response.routes[0].legs[0];
      setTimeout(function() {
        map.setZoom(16); // ルート表示後にズーム率を変更
      });
    }
  });
  function attachMessage(marker, msg) {
    google.maps.event.addListener(marker, "click", function(event) {
      new google.maps.InfoWindow({
        content: msg
      }).open(marker.getMap(), marker);
    });
  }
}
window.initMapRoutes = initMapRoutes;
