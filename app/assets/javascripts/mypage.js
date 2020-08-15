$(document).on('turbolinks:load', function() {

  $(".user__mypage__sidebar__list__item").on("mouseover", function() {
    $(this).css("background-color", "#dcdcdc");
    $(this).children(".user__mypage__sidebar__list__item__arrow").css("transition", "0.3s");
    $(this).children(".user__mypage__sidebar__list__item__arrow").css("color", "#000000");
    $(this).children(".user__mypage__sidebar__list__item__arrow").css("transform", "translateX(10px)");
  });

  $(".user__mypage__sidebar__list__item").on("mouseout", function() {
    $(this).css("background-color", "#ffffff");
    $(this).children(".user__mypage__sidebar__list__item__arrow").css("transition", "0.3s");
    $(this).children(".user__mypage__sidebar__list__item__arrow").css("color", "#dcdcdc");
    $(this).children(".user__mypage__sidebar__list__item__arrow").css("transform", "translateX(0px)");
  });
});
