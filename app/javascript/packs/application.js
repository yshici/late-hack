// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("timepicker.js")
require("moment")
require("tempusdominus-bootstrap-4")
require("google_maps.js")
require("google_maps_routes.js")

import '@fortawesome/fontawesome-free/js/all'
import '../stylesheets/application'
import '../stylesheets/google_maps'
import '../stylesheets/simple_calendar_custom';

// エンターキーによるsubmitを無効化
$(document).ready(function () {
  $('.ignore-enterkey').keypress(function (e) {
    if (!e) var e = window.event;
    if (e.keyCode == 13)
      return false;
  });
});

$(window).on('load resize', function(){
  var windowWidth = $(window).width();
  if (windowWidth <= 767) {
    $("#calendar-month-display").hide();
    $("#calendar-week-display").show();
    // document.getElementById("calendar-month-display").style.display="none";
    // document.getElementById("calendar-week-display").style.display="block";
  } else {
    $("#calendar-month-display").show();
    $("#calendar-week-display").hide();
    // document.getElementById("calendar-month-display").style.display="block";
    // document.getElementById("calendar-week-display").style.display="none";
  }
});