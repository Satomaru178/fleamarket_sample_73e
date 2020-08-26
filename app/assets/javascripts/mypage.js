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

  const tabs = $(".user__mypage__main__buy__list__item")
  function tabSwitch() {
    $('.active').removeClass("active");

    $(this).addClass("active");

    const index = tabs.index(this);

    $(".user__mypage__main__buy__items").removeClass("show").eq(index).addClass("show");
  }
  tabs.click(tabSwitch);

  $(".user__mypage__main__buy__item").on("mouseover", function() {
    $(this).css("transition", "0.5s");
    $(this).css("background-color", "#dcdcdc");
  });

  $(".user__mypage__main__buy__item").on("mouseout", function(){
    $(this).css("transition", "0.5s");
    $(this).css("background-color", "#ffffff");
  });

});
