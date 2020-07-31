$(document).on('turbolinks:load', ()=> {

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
});
