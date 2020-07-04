$(document).on('turbolinks:load', ()=> {
  const arraySize = 10;

  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html =
    `
    <div data-index="${index}" class="js-file_group">
      <input class="js-file" type="file"
      name="product[images_attributes][${index}][src]"
      id="product_images_attributes_${index}_src"><br>
      <div class="js-remove">削除</div>
    </div>
    `;
    return html;
  }

  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [...Array(arraySize)].map((_,i) => i + 1);

  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    }
    else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));

      // 画像入力欄が10個以上にならないようにする
      if ($('.js-file').length < arraySize) {
        // fileIndexの先頭の数字を使ってinputを作る
        $('#image-box').append(buildFileField(fileIndex[0]));
      }
      else {
        ;
      }
      fileIndex.shift();
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexに振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) {
      hiddenCheck.prop('checked', true);
    }
    else {
      ;
    }

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) {
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
    }
    else if ($('.js-file').length == (arraySize - 1)) {
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      // 削除したindexを追加する
      fileIndex.push(targetIndex + 1);
    }
    else {
      // 削除したindexを追加する
      fileIndex.push(targetIndex + 1);
    }
  });
});
