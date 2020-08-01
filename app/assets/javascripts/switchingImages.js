$(document).on('turbolinks:load', function() { 
  $(".content-main__top__product__images__image__lists__list").first().addClass("active"); // 1枚目の小画像をアクティブに変更
  $('.content-main__top__product__images__image__lists__list-sub').click(function () { // 小さい画像がクリックされたらイベント発火
    if ( $(this).hasClass("active") ) {// activeクラスを持っていた場合はreturn処理
      return;
    } 
    image_url = $(this).attr("src"); // クリックされた画像のPATHを取得
    $("img#main").attr("src", image_url).hide().fadeIn(); // メイン画像をクリックされた画像に変更
    $(".content-main__top__product__images__image__lists__list.active").removeClass("active"); // 1枚目の小画像のアクティブを無効化
    $(this).parent().addClass("active"); // クリックされた小画像をアクティブに変更
    return false;
  });
});
