$(document).on('turbolinks:load', function() {
  // ===================================
  // 新規コメント表示用・自分のコメント復元用 
  // ===================================
  function new_comment(comment_data){
    const HTML_user =
      `
      <li class="content-main__comments__list__block" data-index=${comment_data.id} id="self">
        <a class="comments__user__self" href="/accounts">
          <figure>
            <div class="comments__user__self__image">
      `
      const HTML_user_icon =
              `
              <img src="${comment_data.user_image}">
              `
      const HTML_user_noimage =
              `
              <img src="/images/member_photo_noimage_thumb.png">
              `
      const HTML_user_name =
          `
            </div>
            <figcaption class="comments__user__self__name">
              ${comment_data.user_nickname}
            </figcaption>
          </figure>
          `
    const HTML_seller =
          `
          <div class="comments__user__self__seller">
            出品者
          </div>
          `
    const HTML_body =
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
        `
    const HTML_deleteBtn =
              `
              <div class="content-main__comments__list__block__content__icons__right__delete self_pre_delete" data-index=${comment_data.id}>
                <a rel="nofollow" data-method="patch" href="/comments/${comment_data.id}">
                  <i class="fas fa-trash-alt"></i>
                </a>
              </div>
              `
    const HTML_closeTag =
      `
            </div>
          </div>
        </div>
      </li>
      `
    
    let html;
    if (comment_data.product_seller.id == comment_data.user_id && comment_data.user_image ){
      // 出品者とコメントしたユーザーが等しく、かつ、ユーザーアイコン画像がある場合
      html = HTML_user + HTML_user_icon + HTML_user_name + HTML_seller + HTML_body + HTML_deleteBtn + HTML_closeTag
    } else if (comment_data.product_seller.id == comment_data.user_id && comment_data.user_image == null ) {
      // 出品者とコメントしたユーザーが等しく、かつ、ユーザーアイコン画像が無い場合
      html = HTML_user + HTML_user_noimage + HTML_user_name + HTML_seller + HTML_body + HTML_deleteBtn + HTML_closeTag
    } else if (comment_data.product_seller.id != comment_data.user_id && comment_data.user_image ) {
      // 出品者とコメントしたユーザーが異なり、かつ、ユーザーアイコン画像がある場合
      html = HTML_user + HTML_user_icon + HTML_user_name + HTML_body + HTML_closeTag
    } else {
      // 出品者とコメントしたユーザーが異なり、かつ、ユーザーアイコン画像が無い場合
      html = HTML_user + HTML_user_noimage + HTML_user_name + HTML_body + HTML_closeTag
    }

    return html; 
  }

  // ===================================
  // 他人のコメント復元用 
  // ===================================
  function restore_other_comment(comment_data){
    const HTML_user =
      `
      <li class="content-main__comments__list__block" data-index=${comment_data.id}>
        <a class="comments__user" href="#">
          <figure>
            <div class="comments__user__image">
      `
    const HTML_user_icon =
              `
              <img src="/uploads/account/icon_image/${comment_data.user_id}/images.jpeg">
              `
    const HTML_user_noimage =
              `
              <img src="/images/member_photo_noimage_thumb.png">
              `
    const HTML_user_name =
          `
            </div>
            <figcaption class="comments__user__name">
              ${comment_data.user_nickname}
            </figcaption>
          </figure>
          `
    const HTML_seller =
          `
          <div class="comments__user__seller">
            出品者
          </div>
          `
    const HTML_body =
      `
        </a>
        <div class="content-main__comments__list__block__content">
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
              <div class="content-main__comments__list__block__content__icons__right__delete other_pre_delete" data-index=${comment_data.id}>
                <a rel="nofollow" data-method="patch" href="/comments/${comment_data.id}">
                  <i class="fas fa-trash-alt"></i>
                </a>
              </div>
            </div>
          </div>
        </div>
      </li>
      `

    let html;
    if (comment_data.product_seller.id == comment_data.user_id && comment_data.user_image ){
      // 出品者とコメントしたユーザーが等しく、かつ、ユーザーアイコン画像がある場合
      html = HTML_user + HTML_user_icon + HTML_user_name + HTML_seller + HTML_body
    } else if (comment_data.product_seller.id == comment_data.user_id && comment_data.user_image == null ) {
      // 出品者とコメントしたユーザーが等しく、かつ、ユーザーアイコン画像が無い場合
      html = HTML_user + HTML_user_noimage + HTML_user_name + HTML_seller + HTML_body
    } else if (comment_data.product_seller.id != comment_data.user_id && comment_data.user_image ) {
      // 出品者とコメントしたユーザーが異なり、かつ、ユーザーアイコン画像がある場合
      html = HTML_user + HTML_user_icon + HTML_user_name + HTML_body
    } else {
      // 出品者とコメントしたユーザーが異なり、かつ、ユーザーアイコン画像が無い場合
      html = HTML_user + HTML_user_noimage + HTML_user_name + HTML_body
    }

    return html; 
  }

  // ===================================
  // 仮削除表示用
  // ===================================

  function preDelete(index){
    const html = 
    `
    <div class="content-main__comments__list__block__content__text-deleted">
    出品者によりこのコメントは削除されました
    </div>
    <div class="content-main__comments__list__block__content__icons">
      <div class="content-main__comments__list__block__content__icons__right">
        <div class="content-main__comments__list__block__content__icons__right__restore restore_btn" data-index=${index}>
          <a href="/comments/${index}/restore">
            <i class="fas fa-recycle"></i>
          </a>
        </div>
        <div class="content-main__comments__list__block__content__icons__right__delete complete_delete" data-index=${index}>
          <a rel="nofollow" data-method="delete" href="/comments/${index}">
            <i class="fas fa-dumpster-fire"></i>
          </a>
        </div>
      </div>
    </div>
    `
    return html;
  }
  // ===================================
  // コメント作成した場合
  // ===================================
  $('.content-main__comments__form__new').on('submit', function(e){
    e.preventDefault();
    const formData = new FormData(this);
    const url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment_data){
      const html = new_comment(comment_data);
      $(".content-main__comments__list").append(html)
      $('.content-main__comments__form__text').val("");
      $('.content-main__comments__list').animate({ scrollTop: $('.content-main__comments__list')[0].scrollHeight});
      $('.content-main__comments__form__btn').prop('disabled', false);
    })
    .fail(function() {
      alert("コメントの送信に失敗しました");
    });
  });

  // ===================================
  // 復元した場合
  // ===================================
  $(".content-main__comments__list").on('click',".restore_btn",function(e){
    e.preventDefault()
    const index = $(this).data("index")
    const url =`/comments/${index}/restore`
    $.ajax({
      url: url,
      type: "get",
      dataType: 'json',
    })
    .done(function(comment_data){
      let html;
      if (comment_data.product_seller.id == comment_data.user_id){   // 出品者とコメントユーザーが同じ場合
        html = new_comment(comment_data);
        $(`.content-main__comments__list__block[data-index=${index}]`).replaceWith(html)
      } else {    // 出品者とコメントユーザーが異なる場合
        html = restore_other_comment(comment_data);
        $(`.content-main__comments__list__block[data-index=${index}]`).replaceWith(html)
      }
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  });

  // ===================================
  // 自分のコメントを仮削除した場合
  // ===================================

  $(".content-main__comments__list").on('click',".self_pre_delete",function(e){
    e.preventDefault()
    const index = $(this).data("index");
    const url =`/comments/${index}`
    $.ajax({
      url: url,
      type: "patch",
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(){
      const content =  $(`.content-main__comments__list__block[data-index=${index}]`).find(".content-main__comments__list__block__content-self");
      content.empty();
      content.append(preDelete(index));
    })
    .fail(function(){
      alert("メッセージの仮削除に失敗しました");
    });
  });

  // ===================================
  // 他人のコメントを仮削除した場合
  // ===================================

  $(".content-main__comments__list").on('click',".other_pre_delete",function(e){
    e.preventDefault()
    const index = $(this).data("index");
    const content =  $(`.content-main__comments__list__block[data-index=${index}]`).find(".content-main__comments__list__block__content");
    content.empty();
    content.append(preDelete(index));
  });

  // ===================================
  // 完全削除した場合
  // ===================================
  $(".content-main__comments__list").on('click','.complete_delete',function(e){
    e.preventDefault()
    const index = $(this).data("index");
    $(`.content-main__comments__list__block[data-index=${index}]`).remove();
  });
});
