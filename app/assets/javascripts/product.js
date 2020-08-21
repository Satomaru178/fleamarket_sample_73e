$(document).on('turbolinks:load', ()=> {

  // 商品出品編集ページ用

  const arraySize = 5;  // 画像の最大保存枚数

  // preview用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html =
    `
    <div>
      <div>画像${index}</div>
      <img data-index="${index}" src="${url}" width="100px" height="100px">
    </div>
    `;

    return html;
  }

  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html =
    `
    <div class="input-box-group" data-index="${index}">
      <div class="image-index">画像${index}</div>
      <div class="input-box">
        <label>
          追加・変更
          <input class="input-box__file" type="file" name="product[images_attributes][${index}][src]" id="product_images_attributes_${index}_src">
        </label>
      </div>
      <div class="js-remove">削除</div>
    </div>
    `;

    return html;
  }

  // 画像用のinputに動的なindexをつける為の配列
  let fileIndex = [...Array(arraySize)].map((_,i) => i);

  for (let i = 0; i < arraySize; i++) {
    // 保存済画像を削除するフラグを取得
    const hiddenCheck = $(`input[data-index="${i}"].hidden-destroy`);
    if (hiddenCheck.prop("checked")) {  // checked
      // previewの画像を削除する
      $(`img[data-index="${i}"]`).parent().remove();
    }
    else {  // unchecked
      hiddenCheck.prop("checked", false);  // フラグを外す
    }

    // 画像に対応するindexを除去
    if ($(`img[data-index="i"]`)[0]) {  // 画像がある?
      fileIndex.splice(i, 1);
    }
    else {  // 画像がない
      // nop
    }
  }

  const lastIndex = $('.input-box-group:last').data('index');

  for (let j = lastIndex + 1; j < arraySize; j++) {
    $('.input-box-groups').append(buildFileField(j));  // 画像用inputを増やす
  }

  // 保存済画像フラグを非表示にする
  $('.hidden-destroy').hide();

  // 画像用のinputが変化した
  $('#image-box').on('change', '.input-box', function(e) {

    // 対応するindexを取得する
    const targetIndex = $(this).parent().data('index');

    // 保存済画像を削除するフラグを外す
    $(`input[data-index="${targetIndex}"].hidden-destroy`).prop("checked", false);

    // 画像ファイルのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (blobUrl) {
      img = $(`img[data-index="${targetIndex}"]`)[0]
      if (img) {  // 既存の画像を変更?
        img.setAttribute('src', blobUrl);
      }
      else {  // 新規の画像を追加
        $('.preview-images').append(buildImg(targetIndex, blobUrl));  // previewに画像を追加

        // indexから追加した画像に対応するものを除去
        const pos = fileIndex.indexOf(targetIndex);
        fileIndex.splice(pos, 1);
      }
    }
    else {  // 画像のURLがない
      // nop
    }
  });

  // 画像用inputの削除ボタンが押された
  $('#image-box').on('click', '.js-remove', function() {

    // 対応するindexを取得する
    const targetIndex = $(this).parent().data('index');

    // 保存済画像を削除するフラグを立てる
    $(`input[data-index="${targetIndex}"].hidden-destroy`).prop('checked', true);

    img = $(`img[data-index="${targetIndex}"]`)[0]
    if (img) {  // 画像がある?
      // previewの画像を削除する
      $(`img[data-index="${targetIndex}"]`).parent().remove();

      // 削除した画像に対応するindexを配列に追加する
      fileIndex.push(targetIndex);
    }
    else {  // ない画像は消せない
      // nop
    }
  });





  // 商品説明文の文字数カウンタ
  $('#product_explain').on('keyup', function() {
    let count = $(this).val().length;
    $('.product-contents__basic__explain__counter__count').text(count + "/1000"); 
  });





  // 販売手数料と販売利益を計算する関数
  let calculate = (price)=> {
    let commission;
    let profit;

    if ((price >= 300) && (price < 10000000)) {  // 販売価格の有効範囲内
      commission = Math.floor(0.1 * price).toLocaleString();
      profit     = Math.ceil(0.9 * price).toLocaleString();
    }
    else {  // 販売価格の有効範囲外
      commission = "---";
      profit     = "---";
    }

    // 再描画
    $('#commission').text(commission + "円");
    $('#profit').text(profit + "円");
  }

  // キー入力またはフォームのボタンにより販売価格が変更された場合
  $('#product_price').on('keyup change', function() {
    let price = $(this).val();
    calculate(price);
  });





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
      <input type="checkbox" name="grandchild_all_check" id="grandchild_all_check" value="1">
      <label for="grandchild_all_check">全選択/全削除</label>
      <div class="detailed-search__contents__forms__form__field" id="grandchild_check_boxes">
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

  $('#cat').on('change', '#grandchild_all_check', function() {  // 全選択/全解除ボタンが押された
    $('input[name="q[category_id_in][]"]').prop('checked', $(this).is(':checked'));  // 全選択の時全解除、全選択でない時全選択
  });

  $('#cat').on('change', $('input[name="q[category_id_in][]"]'), function() {  // 手動で変更された
    const check = $('#grandchild_check_boxes :checked').length;
    const input = $('#grandchild_check_boxes :input[type="checkbox"]').length;

    if (check == input) {  // 全選択状態?
      $('#grandchild_all_check').prop('checked', true);  // チェックを入れる
    }
    else {  // 全選択状態でない
      $('#grandchild_all_check').prop('checked', false);  // チェックを外す
    }
  });





  // 全選択/全解除ボタン
  const condition_check_boxes = $('input[name="q[condition_id_in][]"]');
  const costburden_check_boxes = $('input[name="q[costburden_id_in][]"]');
  const shippingperiod_check_boxes = $('input[name="q[shippingperiod_id_in][]"]');

  $('.all-check-btn').on('change', function() {  // 全選択/全解除ボタンが押された
    switch ($(this).prop('id')) {
      case 'condition_all_check':
        condition_check_boxes.prop('checked', $(this).is(':checked'));  // 全選択の時全解除、全選択でない時全選択
        break;
      case 'costburden_all_check':
        costburden_check_boxes.prop('checked', $(this).is(':checked'));  // 全選択の時全解除、全選択でない時全選択
        break;
      case 'shippingperiod_all_check':
        shippingperiod_check_boxes.prop('checked', $(this).is(':checked'));  // 全選択の時全解除、全選択でない時全選択
        break;
      default:
        break;
    }
  });

  condition_check_boxes.on('change', function() {  // 手動で変更された
    const check = $('#condition_check_boxes :checked').length;
    const input = $('#condition_check_boxes :input[type="checkbox"]').length;

    if (check == input) {  // 全選択状態?
      $('#condition_all_check').prop('checked', true);  // チェックを入れる
    }
    else {  // 全選択状態でない
      $('#condition_all_check').prop('checked', false);  // チェックを外す
    }
  });

  costburden_check_boxes.on('change', function() {  // 手動で変更された
    const check = $('#costburden_check_boxes :checked').length;
    const input = $('#costburden_check_boxes :input[type="checkbox"]').length;

    if (check == input) {  // 全選択状態?
      $('#costburden_all_check').prop('checked', true);  // チェックを入れる
    }
    else {  // 全選択状態でない
      $('#costburden_all_check').prop('checked', false);  // チェックを外す
    }
  });

  shippingperiod_check_boxes.on('change', function() {  // 手動で変更された
    const check = $('#shippingperiod_check_boxes :checked').length;
    const input = $('#shippingperiod_check_boxes :input[type="checkbox"]').length;

    if (check == input) {  // 全選択状態?
      $('#shippingperiod_all_check').prop('checked', true);  // チェックを入れる
    }
    else {  // 全選択状態でない
      $('#shippingperiod_all_check').prop('checked', false);  // チェックを外す
    }
  });





  // ソート機能
  $('select[name=sort_order]').on('change', function() {  // 並べ替えのセレクトボックスが変化した
    const sort_order = $(this).val();
    let html;
    switch (sort_order) {
      case 'created_at DESC':
        html = "&sort_order=created_at+DESC";
        break;
      case 'created_at ASC':
        html = "&sort_order=created_at+ASC";
        break;
      case 'price DESC':
        html = "&sort_order=price+DESC";
        break;
      case 'price ASC':
        html = "&sort_order=price+ASC";
        break;
      case 'likes_count DESC':
        html = "&sort_order=likes_count+DESC";
        break;
      default:
        html = "&sort_order=created_at+DESC";
        break;
    }

    let current_html = window.location.href;  // urlを取得
    if (current_html.match(/&sort_order=(created_at|price|likes_count)\+(DESC|ASC)/)) {  // すでにソート済みの場合
      const replaced_html = current_html.match(/&sort_order=(created_at|price|likes_count)\+(DESC|ASC)/)[0];  // 抽出
      current_html = current_html.replace(replaced_html, html);  // 置き換え
    }
    else {  // 初回
      current_html = current_html + "?utf8=✓" + html;  // 並べ替え
    }
    window.location.href = current_html;  // 更新
  });





  // 販売状況ラジオボタン
  $('input[type="radio"]').on('change', function() {  // ラジオボタンが変更された
    const selected = $(this).attr('id');

    switch (selected) {
      case 'q_buyer_id_eq_':
        $('#q_buyer_id_eq_').prop('checked', true);         // チェックを入れる
        $('#q_buyer_id_null_true').prop('checked', false);  // チェックを外す
        $('#q_buyer_id_gt_0').prop('checked', false);       // チェックを外す
        break;
      case 'q_buyer_id_null_true':
        $('#q_buyer_id_eq_').prop('checked', false);       // チェックを外す
        $('#q_buyer_id_null_true').prop('checked', true);  // チェックを入れる
        $('#q_buyer_id_gt_0').prop('checked', false);      // チェックを外す
        break;
      case 'q_buyer_id_gt_0':
        $('#q_buyer_id_eq_').prop('checked', false);        // チェックを外す
        $('#q_buyer_id_null_true').prop('checked', false);  // チェックを外す
        $('#q_buyer_id_gt_0').prop('checked', true);        // チェックを入れる
        break;
      default:
        $('#q_buyer_id_eq_').prop('checked', true);         // チェックを入れる
        $('#q_buyer_id_null_true').prop('checked', false);  // チェックを外す
        $('#q_buyer_id_gt_0').prop('checked', false);       // チェックを外す
        break;
    }
  });





  // ページ更新後のフォームを現在の状態に変える
  $(function() {
    const current_html = window.location.href;  // urlを取得

    // 販売状況ラジオボタン
    if (current_html.match(/buyer_id_(eq|null|gt)/)) {
      const selected = current_html.match(/buyer_id_(eq|null|gt)/)[0];

      // urlから現在の並び順を推定しラジオボタンを変更する
      switch (selected) {
        case "buyer_id_eq":
          $('#q_buyer_id_eq_').prop('checked', true);         // チェックを入れる
          $('#q_buyer_id_null_true').prop('checked', false);  // チェックを外す
          $('#q_buyer_id_gt_0').prop('checked', false);       // チェックを外す
          break;
        case "buyer_id_null":
          $('#q_buyer_id_eq_').prop('checked', false);       // チェックを外す
          $('#q_buyer_id_null_true').prop('checked', true);  // チェックを入れる
          $('#q_buyer_id_gt_0').prop('checked', false);      // チェックを外す
          break;
        case "buyer_id_gt":
          $('#q_buyer_id_eq_').prop('checked', false);        // チェックを外す
          $('#q_buyer_id_null_true').prop('checked', false);  // チェックを外す
          $('#q_buyer_id_gt_0').prop('checked', true);        // チェックを入れる
          break;
        default:
          $('#q_buyer_id_eq_').prop('checked', true);         // チェックを入れる
          $('#q_buyer_id_null_true').prop('checked', false);  // チェックを外す
          $('#q_buyer_id_gt_0').prop('checked', false);       // チェックを外す
          break;
      }
    }
    else {
      // nop
    }
    
    // 並べ替えセレクトボックス
    if (current_html.match(/&sort_order=(created_at|price|likes_count)\+(DESC|ASC)/)) {
      const current_order = current_html.match(/&sort_order=(created_at|price|likes_count)\+(DESC|ASC)/)[0];

      // urlから現在の並び順を推定しセレクトボックスを変更する
      switch (current_order) {
        case "&sort_order=created_at+DESC":
          $('select[name=sort_order] option[value="created_at DESC"]').prop('selected', true);
          break;
        case "&sort_order=created_at+ASC":
          $('select[name=sort_order] option[value="created_at ASC"]').prop('selected', true);
          break;
        case "&sort_order=price+DESC":
          $('select[name=sort_order] option[value="price DESC"]').prop('selected', true);
          break;
        case "&sort_order=price+ASC":
          $('select[name=sort_order] option[value="price ASC"]').prop('selected', true);
          break;
        case "&sort_order=likes_count+DESC":
          $('select[name=sort_order] option[value="likes_count DESC"]').prop('selected', true);
          break;
        default:
          $('select[name=sort_order] option[value]').prop('selected', true);
          break;
      }
    }
    else {
      // nop
    }
  });
});
