$(document).on('turbolinks:load', ()=> {

  // 商品出品編集ページ用

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
    <div class='product-contents__details__categories__category__wrapper__added' id='children_wrapper'>
      <div class='product-contents__details__categories__category__wrapper__box'>
        <select class='product-contents__details__categories__category__wrapper__box--select' id='child_category' name="">
          <option value='---' data-category='---'>子カテゴリーを選択してください</option>
          ${insertHTML}
        </select>
      </div>
    </div>
    `;
    $('.product-contents__details__categories__category').append(html);
  }

  // 孫カテゴリーの表示を生成、追加
  const appendGrandchildrenBox = (insertHTML)=> {
    let html =
    `
    <div class='product-contents__details__categories__category__wrapper__added' id='grandchildren_wrapper'>
      <div class='product-contents__details__categories__category__wrapper__box'>
        <select class='product-contents__details__categories__category__wrapper__box--select' id='grandchild_category' name="product[category_id]">
          <option value='---' data-category='---'>孫カテゴリーを選択してください</option>
          ${insertHTML}
        </select>
      </div>
    </div>
    `;
    $('.product-contents__details__categories__category').append(html);
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
  $('.product-contents__details__categories__category').on('change', '#child_category', function() {
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





  // 詳細検索用

  // 子カテゴリーセレクトボックスのオプション設定
  const buildOption2 = (category)=> {
    let html =
    `
    <option value="${category.id}">
      ${category.name}
    </option>
    `;
    return html;
  }

  // 子カテゴリーの表示を生成、追加
  const appendChildrenBox2 = (insertHTML)=> {
    let html =
    `
    <div id="child-cat">
      <div class="detailed-search__contents__forms__form__label">
        <label for="q_category_child_id">子カテゴリー</label>
      </div>
      <div class="detailed-search__contents__forms__form__field">
        <select name="q[category_id]" id="q_category_child_id">
          <option value>指定なし</option>
          ${insertHTML}
        </select>
      </div>
    </div>
    `;
    $('#cat').append(html);
  }

  // 孫カテゴリーチェックボックスの作成
  const buildCheckBox = (category)=> {
    let html =
    `
    <input type="checkbox" value="${category.id}" name="q[category_id_in][]" id="q_category_id_in_${category.id}">
    <label for="q_category_id_in_${category.id}">${category.name}</label>
    `;
    return html;
  }

  // 孫カテゴリーの表示を生成、追加
  const appendGrandchildrenBox2 = (insertHTML)=> {
    let html =
    `
    <div id="grandchild-cat">
      <div class="detailed-search__contents__forms__form__label">
        <label for="q_category_id">孫カテゴリー</label>
      </div>
      <div class="detailed-search__contents__forms__form__field">
        <input type="hidden" name="q[category_id_in][]" value>
        ${insertHTML}
      </div>
    </div>
    `;
    $('#cat').append(html);
  }

  // 親カテゴリーのセレクトボックスが変化した
  $('#parent-cat').on('change', function() {
    // 選択された親カテゴリーを抽出
    let parentCategory = $('#q_category_id option:selected').val();
    if (parentCategory) {  // 初期値以外が選択されている
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#child-cat').remove();  // 一旦削除する
        $('#grandchild-cat').remove();

        let insertHTML='';

        children.forEach(function(child) {
          insertHTML += buildOption2(child);
        });

        appendChildrenBox2(insertHTML);
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      });
    }
    else {  // 初期値になっている
      $('#child-cat').remove();  // 一旦削除する
      $('#grandchild-cat').remove();
    }
  });

  // 子カテゴリーのセレクトボックスが変化した
  $('#cat').on('change', '#q_category_child_id', function() {
    // 選択された親カテゴリーを抽出
    let childCategory = $('#q_category_child_id option:selected').val();
    if (childCategory) {  // 初期値以外が選択されている
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childCategory },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren) {
          $('#grandchild-cat').remove();  // 一旦削除する
          let insertHTML='';

          grandchildren.forEach(function(grandchild) {
            insertHTML += buildCheckBox(grandchild);
          });

          appendGrandchildrenBox2(insertHTML);
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
      $('#grandchild-cat').remove();  // 一旦削除する
    }
  });
});
