$(document).on('turbolinks:load', function() {

  $(".user__mypage__product").on("mouseover", function() {
    $(this).css("transition", "0.5s");
    $(this).css("background-color", "#dcdcdc");
  });

  $(".user__mypage__product").on("mouseout", function(){
    $(this).css("transition", "0.5s");
    $(this).css("background-color", "#ffffff");
  });
});
