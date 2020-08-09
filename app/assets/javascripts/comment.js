$(document).on('turbolinks:load', function() {
  // 新規コメント
  function new_comment(comment_data){
    var HTML_user =
      `
      <li class="content-main__comments__list__block" data-index=${comment_data.id} id="self">
        <a class="comments__user__self" href="/accounts">
          <figure>
            <div class="comments__user__self__image">
              <img src="/assets/material/icon/member_photo_noimage_thumb.png">
            </div>
            <figcaption class="comments__user__self__name">
              ${comment_data.user_nickname}
            </figcaption>
          </figure>
      `
    var HTML_seller =
          `
          <div class="comments__user__self__seller">
            出品者
          </div>
          `
    var HTML_body =
        `
        </a>
        <div class="content-main__comments__list__block__content-self">
          <div class="content-main__comments__list__block__content__text">${comment_data.comment}
          </div>
          <div class="content-main__comments__list__block__content__icons">
            <time class="content-main__comments__list__block__content__icons__left">
              <i class="fas content-main__comments__list__block__content__icons__left__time fa-clock"></i>
              <span>
                ${comment_data.created_at}
              </span>
            </time>
            <div class="content-main__comments__list__block__content__icons__right">
              <div class="content-main__comments__list__block__content__icons__right__flag">
                <a href="#">
                  <i class="far fa-flag"></i>
                </a>
              </div>
        `
    var HTML_deleteBtn =
              `
              <div class="content-main__comments__list__block__content__icons__right__delete self_pre_delete" data-index=${comment_data.id}>
                <a rel="nofollow" data-method="patch" href="/comments/${comment_data.id}">
                  <i class="fas fa-trash-alt"></i>
                </a>
              </div>
              `
    var HTML_closeTag =
      `
            </div>
          </div>
        </div>
      </li>
      `
    if (comment_data.product_seller.id == comment_data.user_id){
      // 出品者とコメントしたユーザーが等しい場合
      var html = HTML_user + HTML_seller + HTML_body + HTML_deleteBtn + HTML_closeTag
    }　else　{
      // 出品者とコメントしたユーザーが異なる場合
      var html = HTML_user + HTML_body + HTML_closeTag
    };

    return html; 
  };

  
  $('.content-main__comments__form__new').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment_data){
      var html = new_comment(comment_data);
      $(".content-main__comments__list").append(html)
      $('.content-main__comments__form__text').val("");
      $('.content-main__comments__list').animate({ scrollTop: $('.content-main__comments__list')[0].scrollHeight});
      $('.content-main__comments__form__btn').prop('disabled', false);
    })
    .fail(function() {
      alert("コメントの送信に失敗しました");
    });
  });
});
