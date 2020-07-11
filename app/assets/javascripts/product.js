$(document).on('turbolinks:load', ()=> {

  const arraySize = 5;  // 画像の最大保存枚数

  // preview用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html =
    `
    <label>
      画像${index}
      <img data-index="${index}" src="${url}" width="100px" height="100px">
    </label>
    `;

    return html;
  }

  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html =
    `
    <div data-index="${index}" class="js-file_group">
      <div class="image-index">画像${index}</div>
      <input class="js-file" type="file"
        name="product[images_attributes][${index}][src]"
        id="product_images_attributes_${index}_src"><br>
      <div class="js-remove">削除</div>
    </div>
    `;

    return html;
  }

  // 画像用のinputに動的なindexをつける為の配列
  let fileIndex = [...Array(arraySize)].map((_,i) => i);

  for (let i = 0; i < arraySize; i++) {
    // 画像に対応するindexを除去
    if ($(`img[data-index="i"]`)[0]) {  // 画像がある?
      fileIndex.splice(i, 1);
    }
    else {  // 画像がない
      // nop
    }
  }

  const lastIndex = $('.js-file_group:last').data('index');

  for (let j = lastIndex + 1; j < arraySize; j++) {
    $('#image-box').append(buildFileField(j));  // 画像用inputを増やす
  }

  // DBに保存されている画像かどうかを判定するフラグを隠す
  $('.hidden-destroy').hide();

  // 画像用のinputが変化した
  $('#image-box').on('change', '.js-file', function(e) {

    // 対応するindexを取得する
    const targetIndex = $(this).parent().data('index');

    // 画像ファイルのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {  // 既存の画像を変更?
      if (blobUrl) {  // 画像のURLがある?
        img.setAttribute('src', blobUrl);
      }
      else {  // 画像のURLがない
        // nop
      }
    }
    else {  // 新規の画像を追加
      if (blobUrl) {  // 画像のURLがある?
        $('#previews').append(buildImg(targetIndex, blobUrl));  // previewに画像を追加

        // indexから追加した画像に対応するものを除去
        const pos = fileIndex.indexOf(targetIndex);
        fileIndex.splice(pos, 1);
      }
      else {  // 画像のURLがない
        // nop
      }
    }
  });

  // 画像用inputの削除ボタンが押された
  $('#image-box').on('click', '.js-remove', function() {

    // 対応するindexが振られているチェックボックスが存在すればチェックを入れる
    const targetIndex = $(this).parent().data('index');
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) {  // チェックボックスが存在する?
      hiddenCheck.prop('checked', true);  // チェックを入れる
    }
    else {  // チェックボックスが存在しない
      // nop
    }

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {  // 画像がある?
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
  $('.contents__product__explain').on('keyup', '#product_explain', function() {
    let count = $(this).val().length;
    $('.contents__product__explain__counter__count').text(count); 
  });





  // 販売手数料と販売利益を計算する関数
  let recalculation = ()=> {
    // 一旦消したのを再描画する
    const rebuild = (value)=> {
      let html;

      if ((value >= 300) && (value < 10_000_000)) {  // 販売価格の有効範囲内
        let commission = Math.ceil(0.1*value);
        let profit     = (value - commission);

        html =
        `
        <div class="contents__product__price__sells-commission">
        販売手数料(10%)
        ${commission.toLocaleString()}円
        </div>
        <div class="contents__product__price__line">
        ------------------------------
        </div>
        <div class="contents__product__price__profit">
        販売利益
        ${profit.toLocaleString()}円
        </div>
        `;
      }
      else {  // 販売価格の有効範囲外
        html =
        `
        <div class="contents__product__price__sells-commission">
        販売手数料(10%)
        ---
        </div>
        <div class="contents__product__price__line">
        ------------------------------
        </div>
        <div class="contents__product__price__profit">
        販売利益
        ---
        </div>
        `;
      }

      return html;
    }

    // 一旦全部消す
    $('.contents__product__price__sells-commission').remove();
    $('.contents__product__price__line').remove();
    $('.contents__product__price__profit').remove();

    // 販売価格の値を取得
    let target = $('#product_price').val();

    // 再描画
    $('.contents__product__price').append(rebuild(target));
  }

  // キー入力による変更の場合
  $('.contents__product__price').on('keyup', function() {
    recalculation();
  });

  // フォームのボタンによる変更の場合
  $('.contents__product__price').on('change', function() {
    recalculation();
  });
});
