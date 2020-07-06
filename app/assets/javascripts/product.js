$(document).on('turbolinks:load', ()=> {

  const arraySize = 5;  // 画像の最大保存枚数

  // preview用のimgタグを生成する関数
  const buildImg = (index, url)=> {

    const html =
    `
    <label>
      画像${index}ddd
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
      <div class="image-index">画像${index}eee</div>
      <input class="js-file" type="file"
        name="product[images_attributes][${index}][src]"
        id="product_images_attributes_${index}_src"><br>
      <div class="js-remove">削除</div>
    </div>
    `;

    return html;

  }

  // 画像用のinputに動的なindexをつける為の配列
  let fileIndex = [...Array(arraySize)].map((_,i) => i + 1);

  // 既に使われているindexを除外
  $('.js-file_group').each(function(){

    const rm = $(this).data('index');
    const pos = fileIndex.indexOf(rm + 1);
    fileIndex.splice(pos, 1);

  });

  // DBに保存されている画像かどうかを判定するフラグを隠す
  $('.hidden-destroy').hide();


  // 画像用のinputが変化した
  $('#image-box').on('change', '.js-file', function(e) {

    // 対応するindexを取得する
    const targetIndex = $(this).parent().data('index');

    // 画像ファイルのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // const test = readAsDataURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {  // 既存の画像を変更?
      if (blobUrl) {  // 画像のURLがある?
        img.setAttribute('src', blobUrl);
      }
      else {  // 画像のURLがない
        console.log("URLエラー");
      }
    }
    else {  // 新規の画像を追加
      if (blobUrl) {  // 画像のURLがある?
        $('#previews').append(buildImg(targetIndex, blobUrl));  // previewに画像を追加
        if ($('.js-file').length < arraySize) {  // 画像用inputの数が最大数より少ない?
          配列の先頭の数字を使ってinputを作る
          $('#image-box').append(buildFileField(fileIndex[0] - 1));
          配列を更新する
          fileIndex.shift();
          console.log(fileIndex);
        }
        else {  // 画像用inputの数が最大数以上となった
          console.log("入力フォーム最大数");
        }
      }
      else {  // 画像のURLがない
        console.log("URLエラー");
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
      console.log("チェックボックスなし");
    }

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {  // 画像がある?
      // previewの画像を削除する
      $(`img[data-index="${targetIndex}"]`).parent().remove();

      if ($('.js-file').length > 1) {  // 画像用inputが複数ある?
        対応するinputを削除する
        $(this).parent().remove();
        配列を更新する
        fileIndex.push(targetIndex + 1);
        console.log(fileIndex);
      }
      else {  // 画像用inputが1個以下
        console.log("入力フォームがなくなっちゃう");
      }
    }
    else {  // ない画像は消せない
      console.log("ない画像は消せない");
      console.log(fileIndex);
    }
  });
});
