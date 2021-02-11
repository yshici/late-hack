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
      if (response.routes[0].overview_path.length < 4) {
        // 出発地・待ち合わせ場所が近い場合
        document.getElementById("nearTweetBtn").style.display ="block";
        document.getElementById("TweetBtn").style.display ="none";
        var lateExcuse = document.getElementById("lateexcuse");
        lateExcuse.textContent = "ついのんびりしてしまいました。";
        var lateTime = document.getElementById("latetime");
        lateTime.textContent = "3時間遅刻できます。";
        var excuse = 'のんびりしていました';
        var latlngPoint = new google.maps.LatLng(response.request.destination.location.lat(), response.request.destination.location.lng());
        debugger;
        addMarker(response);
        function addMarker(response) {
          var marker = new google.maps.Marker({
            position: latlngPoint,
            map: map
          });
          var contentString =
            `<div id="ababab">` +
              `<p>${ excuse }</p>` +
            `</div>`;
          var infowindow = new google.maps.InfoWindow({
            content: contentString,
            position: marker.position,
            maxWidth: 100,
          });
          infowindow.open(marker.position, marker);
          attachInfoWindow(marker, infowindow);
          map.setCenter(latlngPoint);
          map.setZoom(1);
        }
        map.setCenter(new GLatLng(response.request.destination.location.lat(), response.request.destination.location.lng()), 10);
        function attachInfoWindow(marker, infowindow) {
          marker.addListener("click", () => {
            infowindow.close(marker.position, marker);
            infowindow.open(marker.position, marker);
          })
        }
      } else {
        setTimeout(function() {
          map.setZoom(16); // ルート表示後にズームを変更
        });
        document.getElementById("TweetBtn").style.display ="block";
        document.getElementById("nearTweetBtn").style.display ="none";
        var lateExcuse = document.getElementById("lateexcuse");
        lateExcuse.textContent = "道中でいろんなことが起こりました。";
        var lateTime = document.getElementById("latetime");
        var SumLateTime = gon.late_time;
        lateTime.textContent = `${ SumLateTime }遅刻できます`;
        // ルートを4分割して1/4、2/4、3/4の点にマーカー
        for (let i = 1; i < 4; i++) {
          addMarker(response, i);
        }
        function addMarker(response, n) {
          var excuse = gon.excuse; // gon使ってコントローラーから読み込み
          var splitNum = Math.round(response.routes[0].overview_path.length * n / 4);
          var latlngPoint = new google.maps.LatLng(response.routes[0].overview_path[splitNum].lat(), response.routes[0].overview_path[splitNum].lng());
          var marker = new google.maps.Marker({
            position: latlngPoint,
            map: map
          });
          var contentString =
          `<div id="ababab">` +
            `<p>${ excuse[n-1]["content"] } <br> ＋ ${ excuse[n-1]["late_time"] }分</p>` +
          `</div>`;
          var infowindow = new google.maps.InfoWindow({
            content: contentString,
            position: marker.position,
            maxWidth: 100,
          });
          infowindow.open(marker.position, marker);
          attachInfoWindow(marker, infowindow);
        }
        function attachInfoWindow(marker, infowindow) {
          marker.addListener("click", () => {
            infowindow.close(marker.position, marker);
            infowindow.open(marker.position, marker);
          })
        }
      }
    } else {
      // 経路取得できない場合エラー
      var errorMsg = document.getElementById("map-error");
      errorMsg.textContent = "経路が取得できませんでした...";
    }
  });
}
window.initMapRoutes = initMapRoutes;
