// 予定入力フォームのカレンダー部分

$(function () {
  var now = new Date();
  $('#datetimepicker13').datetimepicker({
    minDate: now.setMinutes(now.getMinutes() - 10),  //10分前以降選択可能
    format: 'YYYY-MM-DD HH:mm',
    inline: true,
    sideBySide: true,
    stepping: 10,
  });
});
