function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 35.6581, lng: 139.7017 },
    zoom: 14,
    mapId: "roadmap",
    mapTypeControl: false,
    streetViewControl: false,
    fullscreenControl: false,
  });
  // 位置情報取得ボタンを作成
  const locationButton = document.createElement("button");
  // const locationButton = document.getElementById("locationButton");
  locationButton.textContent = "現在地へ移動";
  locationButton.classList.add("custom-map-control-button");
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(locationButton);
  locationButton.addEventListener("click", () => {
    console.log(window.event.keyCode);
    console.log(window.event.which);
    event.preventDefault();
    if (window.event.keyCode === 13) {
      console.log('geolocationEnterKey確認');
      return false
    } else {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude,
            };
            map.setCenter(pos);
          },
        );
      } else {
        return false
      }
    }
  });

  // 検索ボックスを作成
  const input = document.getElementById("pac-input");
  const searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  // 検索結果で表示範囲変更する
  map.addListener("bounds_changed", () => {
    searchBox.setBounds(map.getBounds());
  });
  let markers = [];
  // 検索で発火
  searchBox.addListener("places_changed", () => {
    const places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }
    // 古いマーカー削除
    markers.forEach((marker) => {
      marker.setMap(null);
    });
    markers = [];
    const bounds = new google.maps.LatLngBounds();
    for (i = 0; i < places.length; i++) {
      if (!places[i].geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      // マーカー作成
      var marker = new google.maps.Marker({
        map,
        title: places[i].name, // 名称
        position: places[i].geometry.location, // 緯度軽度
        address: places[i].formatted_address, // 住所
      })
      // infowindow表示内容
      const contentString =
        `<div id="ababab">` +
          `<p>${ marker.title }</p>` +
          `<p>${ marker.address }</p>` +
          `<input type="button" value="出発地点に設定" id="addStartPoint">` +
          `<input type="button" value="待ち合わせ場所に設定" id="addDestination">` +
        `</div>`;
      markers.push(
        new google.maps.Marker({marker})
      );
      attachInfoWindow(marker, places, contentString, i);

      if (places[i].geometry.viewport) {
        bounds.union(places[i].geometry.viewport);
      } else {
        bounds.extend(places[i].geometry.location);
      }
    };
    map.fitBounds(bounds);
  });
  // Infowindowを１つのみ開くために設定
  var currentInfoWindow = null;
  // マップ上のデフォルトで表示されるアイコンをクリックすると発火
  map.addListener( "click", function ( argument ) {
    if (argument.placeId) {
      var placeId = argument.placeId;
      var service = new google.maps.places.PlacesService(map);
      service.getDetails({
        placeId: placeId,
        fields: ['name', 'formatted_address', 'geometry']
      }, function(placeOnMap, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
          var contentOnMap =
            `<div id="ababab">` +
            `<p>${ placeOnMap.name }</p>` +
            `<p>${ placeOnMap.formatted_address }</p>` +
            `<input type="button" value="出発地点に設定" id="addStartPoint">` +
            `<input type="button" value="待ち合わせ場所に設定" id="addDestination">` +
            `</div>`;
          var infowindow = new google.maps.InfoWindow({
            content: contentOnMap,
            position: argument.latLng
          });
          if (currentInfoWindow) {
            currentInfoWindow.close();
          }
          infowindow.open(map);
          currentInfoWindow = infowindow;
          // HTMLのformに値を送信
          infowindow.addListener('domready', () => {
            document.getElementById("addStartPoint").addEventListener("click", () => {
              document.getElementById("data-start-point-name").value = placeOnMap.name;
              document.getElementById("data-start-point-location").value = placeOnMap.geometry.location;
              document.getElementById("data-start-point-address").value = placeOnMap.formatted_address;
            });
            document.getElementById("addDestination").addEventListener("click", () => {
              document.getElementById("data-destination-name").value = placeOnMap.name;
              document.getElementById("data-destination-location").value = placeOnMap.geometry.location;
              document.getElementById("data-destination-address").value = placeOnMap.formatted_address;
            });
          });
        }
      });
    };
  });
  // マップ上クリックでinfowindow閉じる
  google.maps.event.addListener(map, 'click', function(){
    if (currentInfoWindow) {
      currentInfoWindow.close();
    }
  });
  // 検索結果のマーカークリックで発火
  function attachInfoWindow(marker, places, contentString) {
    var infowindow = new google.maps.InfoWindow({
      content: contentString,
    });
    marker.addListener("click", () => {
      if (currentInfoWindow) {
        currentInfoWindow.close();
      }
      infowindow.open(marker.get("map"), marker);
      currentInfoWindow = infowindow;
      // HTMLのformに値を送信
      infowindow.addListener('domready', () => {
        document.getElementById("addStartPoint").addEventListener("click", () => {
          document.getElementById("data-start-point-name").value = marker.title;
          document.getElementById("data-start-point-location").value = marker.position;
          document.getElementById("data-start-point-address").value = marker.address;
        });
        document.getElementById("addDestination").addEventListener("click", () => {
          document.getElementById("data-destination-name").value = marker.title;
          document.getElementById("data-destination-location").value = marker.position;
          document.getElementById("data-destination-address").value = marker.address;
        });
      });
    });
  }
}
window.initMap = initMap;
