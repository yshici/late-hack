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
      let leg = response.routes[0].legs[0];
      setTimeout(function() {
        map.setZoom(16); // ルート表示後にズームを変更
      });
      // ルートを4分割して1/4、2/4、3/4の点にマーカー
      for (let i = 1; i < 4; i++) {
        addMarker(response, i);
      }
      function addMarker(response, n) {
        var hoge = gon.hoge; // gon使ってコントローラーから読み込み
        var hogeRandomNum = Math.floor(Math.random()*3);
        hogeRandomNum = Math.floor(Math.random()*hoge.length);
        var splitNum = Math.round(response.routes[0].overview_path.length * n / 4);
        var latlng = new google.maps.LatLng(response.routes[0].overview_path[splitNum].lat(), response.routes[0].overview_path[splitNum].lng());
        var marker = new google.maps.Marker({
          position: latlng,
          map: map
        });
        var infowindow = new google.maps.InfoWindow({
          content: hoge[hogeRandomNum],
          position: marker.position,
        });
        infowindow.open(marker.position, marker);
      }
    }
  });
}
window.initMapRoutes = initMapRoutes;
