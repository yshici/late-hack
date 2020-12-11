function initMapRoutes() {
  map = new google.maps.Map(document.getElementById("map_routes"), {
    center: { lat: 35.6581, lng: 139.7017 },
    zoom: 14,
    mapId: "8e0a97af9386fef",
    mapTypeControl: false,
    streetViewControl: false,
    fullscreenControl: false,
  });
  let rendererOptions = {
    map: map,
    draggable: true,
    preserveViewport: true
  };
  var latlng = gon.latlng;
  let directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
  let directionsService = new google.maps.DirectionsService();
  directionsDisplay.setMap(map);
  let request = {
  origin: new google.maps.LatLng(latlng[1][0], latlng[1][1]), // 出発地点
  destination: new google.maps.LatLng(latlng[0][0], latlng[0][1]), // 待ち合わせ場所
  travelMode: google.maps.DirectionsTravelMode.WALKING, // 移動手段
  };
  directionsService.route(request, function(response,status) {
    if (status === google.maps.DirectionsStatus.OK) {
      new google.maps.DirectionsRenderer({
        map: map,
        directions: response,
      });
      let leg = response.routes[0].legs[0];
      setTimeout(function() {
        map.setZoom(16); // ルート表示後にズームを変更
      });
      // ルートを4分割して1/4、2/4、3/4の点にマーカー
      for (let i = 1; i < 4; i++) {
        addMarker(response, i);
      }
      function addMarker(response, n) {
        var excuse = gon.excuse; // gon使ってコントローラーから読み込み
        var excuseRandomNum = Math.floor(Math.random()*excuse.length);
        var splitNum = Math.round(response.routes[0].overview_path.length * n / 4);
        var latlngPoint = new google.maps.LatLng(response.routes[0].overview_path[splitNum].lat(), response.routes[0].overview_path[splitNum].lng());
        var marker = new google.maps.Marker({
          position: latlngPoint,
          map: map
        });
        var infowindow = new google.maps.InfoWindow({
          content: excuse[excuseRandomNum],
          position: marker.position,
        });
        infowindow.open(marker.position, marker);
      }
    }
  });
}
window.initMapRoutes = initMapRoutes;
