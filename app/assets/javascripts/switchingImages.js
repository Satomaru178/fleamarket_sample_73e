$(document).on('turbolinks:load', function() { 
  $("img.content-main__top__product__images__image__lists__list-sub").click(function(){
    const ImgSrc = $(this).attr("src");
    $("img#main").attr({src:ImgSrc});
    $("img#main").hide();
    $("img#main").fadeIn("slow");
    return false;
  });
});
