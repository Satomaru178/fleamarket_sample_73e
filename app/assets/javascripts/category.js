$(document).on('turbolinks:load', ()=> {
  // カテゴリーセレクトボックスのオプション設定
  const buildOption = (category)=> {
    let html =
    `
    <option value="${category.id}" data-category="${category.id}">
      ${category.name}
    </option>
    `;
    return html;
  }

  // 子カテゴリーの表示を生成、追加
  const appendChildrenBox = (insertHTML)=> {
    let html =
    `
    <div class='contents__product__details__categories__category__wrapper__added' id='children_wrapper'>
      <div class='contents__product__details__categories__category__wrapper__box'>
        <select class='contents__product__details__categories__category__wrapper__box--select' id='child_category' name="">
          <option value='---' data-category='---'>子カテゴリーを選択してください</option>
          ${insertHTML}
        </select>
      </div>
    </div>
    `;
    $('.contents__product__details__categories__category').append(html);
  }

  // 孫カテゴリーの表示を生成、追加
  const appendGrandchildrenBox = (insertHTML)=> {
    let html =
    `
    <div class='contents__product__details__categories__category__wrapper__added' id='grandchildren_wrapper'>
      <div class='contents__product__details__categories__category__wrapper__box'>
        <select class='contents__product__details__categories__category__wrapper__box--select' id='grandchild_category' name="product[category_id]">
          <option value='---' data-category='---'>孫カテゴリーを選択してください</option>
          ${insertHTML}
        </select>
      </div>
    </div>
    `;
    $('.contents__product__details__categories__category').append(html);
  }

  $('#product_category_id').attr('name', "");

  // 親カテゴリーのセレクトボックスが変化した
  $('#parent_category').on('change', function() {
    // 選択された親カテゴリーを抽出
    let parentCategory = $('#parent_category option:selected').val();
    if (parentCategory) {  // 初期値以外が選択されている
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();  // 一旦削除する
        $('#grandchildren_wrapper').remove();

        let insertHTML='';

        children.forEach(function(child) {
          insertHTML += buildOption(child);
        });

        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      });
    }
    else {  // 初期値になっている
      $('#children_wrapper').remove();  // 一旦削除する
      $('#grandchildren_wrapper').remove();
    }
  });

  // 子カテゴリーのセレクトボックスが変化した
  $('.contents__product__details__categories__category').on('change', '#child_category', function() {
    // 選択された親カテゴリーを抽出
    let childId = $('#child_category option:selected').data('category');
    if (childId != "---") {  // 初期値以外が選択されている
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        console.log(grandchildren);
        if (grandchildren) {
          $('#grandchildren_wrapper').remove();  // 一旦削除する
          let insertHTML='';

          grandchildren.forEach(function(grandchild) {
            insertHTML += buildOption(grandchild);
          });

          appendGrandchildrenBox(insertHTML);
        }
        else {
          // nop
        }
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      });
    }
    else {  // 初期値になっている
      $('#grandchildren_wrapper').remove();  // 一旦削除する
    }
  });
});
