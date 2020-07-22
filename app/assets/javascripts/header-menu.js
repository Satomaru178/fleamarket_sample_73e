$(document).on('turbolinks:load', ()=> {
  $(".header__contents__lower__left-items__categories").hover(function() {
    $(".category1").not(":animated").toggleClass("appeared");
  });

  $(".parent__list").hover(function() {
    $(".category2").not(":animated").toggleClass("appeared");
  });

  $(".child__list").hover(function() {
    $(".category3").not(":animated").toggleClass("appeared");
  });
});
