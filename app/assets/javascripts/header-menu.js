$(function(){
  $(".header__contents__lower__left-items__categories").hover(function(){
    $(".category1").addClass("appeared");
  }, function(){
    $(".category1").removeClass("appeared");
  });
  $(".parent__list").hover(function(){
    $(".category2").addClass("appeared");
  }, function(){
    $(".category2").removeClass("appeared");
  });
  $(".child__list").hover(function(){
    $(".category3").addClass("appeared");
  }, function(){
    $(".category3").removeClass("appeared");
  });

});
