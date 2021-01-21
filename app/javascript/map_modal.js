$(document).on("click", "#addStartPoint, #addDestination", function() {
  //.modalについたhrefと同じidを持つ要素を探す
  var modalId = $(this).attr('href');
  var modalThis = $('body').find(modalId);
  //bodyの最下にwrapを作る
  $('body').append('<div id="modalWrap" />');
  var wrap = $('#modalWrap'); wrap.fadeIn('200');
  modalThis.fadeIn('200');
  //モーダルの高さを取ってくる
  function mdlHeight() {
	var wh = $(window).innerHeight();
	var attH = modalThis.find('.modalInner').innerHeight();
	modalThis.css({ height: attH });
  }
  mdlHeight();
  $(window).on('resize', function () {
	mdlHeight();
  });
  function clickAction() {
	modalThis.fadeOut('200');
	wrap.fadeOut('200', function () {
	  wrap.remove();
    });
  }
  //wrapクリックされたら
  wrap.on('click', function () {
	clickAction(); return false;
  });
  //2秒後に消える
  setTimeout(clickAction, 2000); return false;
});
