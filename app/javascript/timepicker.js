// 予定入力フォームのカレンダー部分

$(function () {
  var now = new Date();
  $('#datetimepicker13').datetimepicker({
    minDate: now.setHours(now.getHours() - 1),  //i時間前まで選択可能
    format: 'YYYY-MM-DD HH:mm',
    inline: true,
    sideBySide: true,
    stepping: 60,
  });
});
