## :orange_book: フリマアプリ
メルカリを参考に作成したWEBアプリケーションです。<br>
誰でも簡単に売り買いが楽しめるアプリの機能を実装しました。<br>
ユーザー登録、商品出品、商品購入などの機能が再現されていますが、実際の取引はできません。<br>
<img width="1089" alt="スクリーンショット 2020-08-27 0 09 50" src="https://user-images.githubusercontent.com/62911575/91321525-ac313380-e7f9-11ea-936a-ebce2c4f9d24.png">
<br>

## :orange_book: 実装した機能
- ユーザー登録・編集機能
- SNS認証による登録、ログイン機能(ローカル環境のみ)
- 商品出品・編集・削除機能
- 商品購入機能（pay.jp）
- カテゴリ機能
- コメント機能
- いいね機能
- 商品検索機能（あいまい検索・詳細検索）
- capistranoによるAWS EC2への自動デプロイ
- ActiveStorageを使用しAWS S3への画像アップロード
<br>

## :orange_book: 本番環境
- URL:    http://54.248.69.170/
<br>

### :orange_book: Basic認証
- ID:     gundam
- PASS:   0079
<br>

### :orange_book: 出品者用テストアカウント
- MAIL:   seller@gmail.com
- PASS:   seller1234
<br>

### :orange_book: 購入者用テストアカウント
- MAIL:   buyer@gmail.com
- PASS:   buyer1234
<br>

## :orange_book: 使用技術(開発環境)
<a href="https://www.ruby-lang.org/ja/"><img src="https://i1.wp.com/qs.nndo.jp/wp-content/uploads/2017/06/ruby.png?fit=393%2C346" height="50px"></a>
<a href="https://railsguides.jp/"><img src="https://job.fellow-s.co.jp/limg/public/wsystem/wp-content/uploads/rails_lo.jpg" height="50px"></a>
<a href="https://www.mysql.com/jp/"><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/o/oasist/20200614/20200614000533.png" height="50px"></a>
<a href="https://unicorn.bogomips.org/"><img src="https://livedoor.sp.blogimg.jp/sasata299/imgs/b/d/bdc11dd3.png" height="50px"></a>
<a href="https://www.nginx.co.jp/"><img src="https://i2.wp.com/tadtadya.com/wp-content/uploads/2017/08/nginx-min-edit.png?fit=626%2C329&ssl=1" height="50px"></a>
<a href="https://github.com/capistrano/capistrano"><img src="https://capistranorb.com/assets/images/CapistranoLogo.png" height="50px"></a>
<br>
<a href="https://haml.info/"><img src="https://haml.info/images/haml.png" height="50px"></a>
<a href="https://sass-lang.com/"><img src="https://cdn.worldvectorlogo.com/logos/sass-1.svg" height="50px"></a>
<a href="https://jquery.com/"><img src="https://cdn.worldvectorlogo.com/logos/jquery-1.svg" height="30px"></a>
<a href="https://github.co.jp/"><img src="https://i.pinimg.com/originals/3c/d5/67/3cd5679f54dc60811383649f9f6ea37d.png" height="50px"></a>
<a href="https://aws.amazon.com/jp/"><img src="https://www.skyarch.net/blog/wp-content/uploads/2014/11/Non-Service_Specific_copy_AWS_Cloud.png" height="50px"></a>
<br>

## :orange_book: 開発体制＆使用ツール
アジャイル開発。2週間ごとにスプリントを設定しました。
- Slack（進捗報告やメンバー間の連絡）
- Trello（タスク管理）
- ZOOM（週2回のMTG）
- スプレッドシート （開発スケジュール、各メンバーの作業時間を把握）
<br>

## :orange_book: Member（Github-link）&担当
### <a href="https://github.com/Satomaru178">吉村</a>
<a href="https://github.com/Satomaru178"><img src="https://avatars2.githubusercontent.com/u/63147677?s=400&u=892b244eb8922295babc96f11011f06b9c4eccb7&v=4" width="50px"></a><br>

- スクラムマスター
- デプロイ担当

**フロントエンド**
- 商品詳細ページ

**バックエンド**
- 商品詳細ページ
- 商品についての質問・コメント機能
- パンくず機能

**工夫したポイント**
- 全体的に、デザインにもしっかりこだわって実装した。
- 商品詳細表示について、画像の切り替えを自然にできるように、JavaScriptを使った。
- コメント機能について、
  - 見た目はシンプルかつスタイリッシュなメルカリを参考にし、同じ見た目になるよう調べながら工夫した。<br>
  - 機能に関しては、同じくメルカリを参考にしたが、学びのために「仮削除」および「復元」機能を独自に実装した。<br>
  - ユーザーが快適に使えるよう、ajaxの非同期通信を使い、コメント時、仮削除時、復元時、完全削除時にロードを介さないような仕様にした。<br>

<br>

### <a href="https://github.com/osawa4017">大澤</a>
<a href="https://github.com/osawa4017"><img src="https://avatars0.githubusercontent.com/u/64793100?s=400&v=4" width="50px"></a><br>

**フロントエンド**
- TOPページ
- 商品出品・編集・削除機能
- 商品検索機能（あいまい検索・詳細検索）

**バックエンド**
- 商品出品・編集・削除機能
- 商品検索機能（あいまい検索・詳細検索）

**工夫したポイント**
- 商品出品・編集ページ
  - ユーザが画像を登録するとプレビューが動的に表示されるようにした。
  - ユーザがカテゴリのプルダウンを選択すると対応する子カテゴリや孫カテゴリのプルダウンが動的に出現するようにした。
- 商品詳細検索ページ
  - プルダウンを選択することによって商品の並べ替えを行えるようにした。
  - 検索条件を選択する際に、複数のチェックボックスを一括で選択・解除できるようにした。

<br>

### <a href="https://github.com/Yuta1634">高橋</a>
<a href="https://github.com/Yuta1634"><img src="https://avatars0.githubusercontent.com/u/63214741?s=400&v=4" width="50px"></a><br>

**フロントエンド**
- xxxxx

**バックエンド**
- xxxxx

**工夫したポイント**
- xxxxx

<br>

### <a href="https://github.com/Fyamada1229">山田</a>
<a href="https://github.com/Fyamada1229"><img src="https://avatars3.githubusercontent.com/u/54790413?s=400&u=ff241ff28650e2f56fb3c27ec21ddd959ae323c2&v=4" width="50px"></a><br>

**フロントエンド**
- 商品購入確認ページ

**バックエンド**
- 商品購入確認ページ

**工夫したポイント**
- 商品購入確認ページではメルカリを参考しながらユーザ目線では、どこを<br>
  見るのかと考えながら、微妙なフォントの調整や文字の大きさ<br>
  など工夫をしました。

<br>

### <a href="https://github.com/kobegoro0930">寺本</a>
<a href="https://github.com/kobegoro0930"><img src="https://avatars3.githubusercontent.com/u/62911575?s=460&v=4" width="50px"></a><br>

**フロントエンド**
- ユーザー登録＆ログイン画面
- カテゴリページ（一覧ページ、カテゴリ別ページ）
- TOPページ商品表示
- お気に入りの追加（TOPページ、商品詳細ページ、マイページ）
- README

**バックエンド**
- カテゴリ機能
- お気に入り機能

**工夫したポイント**

<br>

ユーザビリティーを意識し、細部にこだわって実装を行いました。
- ユーザー登録ページのプログレスバーの設置
- マイページのいいね一覧ページで条件分岐によるビューの表示変更
- カテゴリ一覧ページでアンカーリンクを設置する

## :orange_book: 課題や今後実装したい機能
- ポイント機能
- ユーザ評価機能
- レスポンシブ対応
- slick等を使った画像のスライド機能
- modalを使用した確認画面等、UIのブラッシュアップ
<br>

## :orange_book: ERD
![09_erd_fleamarket_sample_73e](https://user-images.githubusercontent.com/64793100/90949078-21aaa600-e480-11ea-80b9-cad65f5d12d2.png)

<br>

## :orange_book: DBテーブル設計

<!--
  ユーザ登録時に入力する基本情報。
-->

### usersテーブル
| Column               | Type   | Option                                            |
|----------------------|--------|---------------------------------------------------|
|nickname              |string  |null: false, unique: true                          |
|email                 |string  |null: false, unique: true, default: "", index: true|
|encrypted_password    |string  |null: false,               default: ""             |
|first_name            |string  |null: false                                        |
|last_name             |string  |null: false                                        |
|first_name_kana       |string  |null: false                                        |
|last_name_kana        |string  |null: false                                        |
|birthday              |date    |null: false                                        |
|reset_password_token  |string  |             unique: true,              index: true|
|reset_password_sent_at|datetime|                                                   |
|remember_created_at   |datetime|                                                   |
|created_at            |datetime|null: false                                        |
|updated_at            |datetime|null: false                                        |

### Association
- has_one  :address
- has_one  :account
- has_one  :creditcard
- has_one  :sns_credential
- has_many :products, dependent: :destroy
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :liked_products, through: likes, source: :product

<br>

<!--
  ユーザ登録時に登録する基本情報。

  prefectureカラム
  都道府県(プルダウン)
  0          : 未選択
  1-47       : 各都道府県
  48         : 未定
-->

### addressesテーブル
| Column        | Type     | Option                |
|---------------|----------|-----------------------|
|user           |references|foreign_key: true      |
|first_name     |string    |null: false            |
|last_name      |string    |null: false            |
|first_name_kana|string    |null: false            |
|last_name_kana |string    |null: false            |
|zipcode        |string    |null: false            |
|prefecture     |integer   |null: false, default: 0|
|city           |string    |null: false            |
|address        |string    |null: false            |
|address_other  |string    |                       |
|tell           |string    |allow_blank: true      |
|created_at     |datetime  |null: false            |
|updated_at     |datetime  |null: false            |

### Association
- belongs_to :user, optional: true

<br>

<!--
  マイページでアイコン画像や背景画像を設定できる。
  設定なしだとデフォルトのものにする。
-->

### accountsテーブル
| Column         | Type     | Option                       |
|----------------|----------|------------------------------|
|user            |references|null: false, foreign_key: true|
|icon_image      |string    |                              |
|background_image|string    |                              |
|profile         |text      |                              |
|created_at      |datetime  |null: false                   |
|updated_at      |datetime  |null: false                   |

### Association
- belongs_to :user
- mount_uploader :icon_image, IconUploader
- mount_uploader :background_image, BackgroundUploader

<br>

<!--
  クレジットカード情報。
  各ユーザは複数枚のカードを登録できる。

  customer_idカラム
  pay.jpでのuser_id

  card_idカラム
  pay.jpでのcard_id
-->

### creditcardsテーブル
| Column    | Type     | Option                       |
|-----------|----------|------------------------------|
|user       |references|null: false, foreign_key: true|
|customer_id|string    |null: false                   |
|card_id    |string    |null: false                   |
|created_at |datetime  |null: false                   |
|updated_at |datetime  |null: false                   |

### Association
- belongs_to :user

<br>

<!--
  商品を出品する時に登録する情報。

  condition_idカラム
  商品の状態(activehashによるプルダウン)
  1 : 新品、未使用
  2 : 未使用に近い
  3 : 目立った傷や汚れなし
  4 : やや傷や汚れあり
  5 : 傷や汚れあり
  6 : 全体的に状態が悪い

  costburden_idカラム
  送料負担(activehashによるプルダウン)
  1 : 送料込み(出品者負担)
  2 : 着払い(購入者負担)

  shippingorigin_idカラム
  発送元住所(activehashによるプルダウン)
  1-47 : 各都道府県
  48   : 未定

  shippingperiod_idカラム
  発送までの期間(activehashによるプルダウン)
  1 : 1〜2日で発送
  2 : 2〜3日で発送
  3 : 4〜7日で発送

  priceカラム
  値段。300円〜9,999,999円まで(数値入力)
  299以下        : エラー
  300-9,999,999 : 値段
  10,000,000以上 : エラー
-->

### productsテーブル
| Column          | Type     | Option                                                                            |
|-----------------|----------|-----------------------------------------------------------------------------------|
|seller           |references|null: false, foreign_key: { to_table: :users }                                     |
|buyer            |references|             foreign_key: { to_table: :users }                                     |
|category         |references|null: false, foreign_key: true                                                     |
|brand            |references|             foreign_key: true                                                     |
|name             |string    |null: false, index: true, length: { maximum: 40 }                                  |
|explain          |text      |null: false,              length: { maximum: 1_000 }                               |
|condition_id     |integer   |null: false                                                                        |
|costburden_id    |integer   |null: false                                                                        |
|shippingorigin_id|integer   |null: false                                                                        |
|shippingperiod_id|integer   |null: false                                                                        |
|price            |integer   |null: false, numericality: { greater_than_or_equal_to: 300, less_than: 10_000_000 }|
|likes_count      |integer   |                                                                                   |
|created_at       |datetime  |null: false                                                                        |
|updated_at       |datetime  |null: false                                                                        |

### Association
- accepts_nested_attributes_for :images, allow_destroy: true
- has_many :images,   dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes,    dependent: :destroy
- belongs_to :seller, class_name: 'User'
- belongs_to :buyer,  class_name: 'User', optional: true
- belongs_to :category
- belongs_to :brand, optional: true
- extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to_active_hash :condition
- belongs_to_active_hash :costburden
- belongs_to_active_hash :shippingorigin
- belongs_to_active_hash :shippingperiod

<br>

<!--
  商品の画像。１枚必須。
-->

### imagesテーブル
| Column   | Type     | Option                       |
|----------|----------|------------------------------|
|product   |references|null: false, foreign_key: true|
|src       |string    |                              |
|created_at|datetime  |null: false                   |
|updated_at|datetime  |null: false                   |

### Association
- belongs_to :product, optional: true
- mount_uploader :src, ImageUploader

<br>

<!--
  カテゴリーはancestryを使って
  カテゴリー、サブカテゴリー、サブサブカテゴリー、商品、
  という階層構造にする。
-->

### categoriesテーブル
| Column   | Type   | Option                                         |
|----------|--------|------------------------------------------------|
|name      |string  |null: false, index: true, length: { maxmum: 40 }|
|ancestry  |string  |             index: true                        |
|created_at|datetime|null: false                                     |
|updated_at|datetime|null: false                                     |

### Association
- has_many :products
- has_ancestry

<br>

<!--
  ブランド名は任意でユーザに入力させる。
  存在しないブランドでも登録できる。
-->

### brandsテーブル
| Column   | Type   | Option                                                        |
|----------|--------|---------------------------------------------------------------|
|name      |string  |null: false, index: true, unique: true, length: { maximum: 40 }|
|created_at|datetime|null: false                                                    |
|updated_at|datetime|null: false                                                    |

### Association
- has_many :products

<br>

<!--
  商品詳細ページでユーザがコメントを残すことができる。
  全てのユーザーが自由にコメントできる。
  出品者は「仮削除」、「完全削除」ができる。
-->

### commentsテーブル
| Column     | Type     | Option                       |
|------------|----------|------------------------------|
|user        |references|null: false, foreign_key: true|
|product     |references|null: false, foreign_key: true|
|comment     |text      |null: false                   |
|delete_check|integer   |default: 0                    |
|created_at  |datetime  |null: false                   |
|updated_at  |datetime  |null: false                   |

### Association
- belongs_to :user
- belongs_to :product

<br>

<!--
  商品詳細ページでユーザがいいね！することができる。
  likeカラム
  いいね！フラグ
  false : いいね！していない状態
  true  : いいね！している状態
-->

### likesテーブル
| Column   | Type     | Option          |
|----------|----------|-----------------|
|user      |references|foreign_key: true|
|product   |references|foreign_key: true|
|created_at|datetime  |null: false      |
|updated_at|datetime  |null: false      |

### Association
- belongs_to :user
- belongs_to :product, counter_cache: :likes_count

<br>

<!--
  SNSを用いてユーザ登録して出品や購入などのサービスを利用することができる。
-->

### snscredentialsテーブル
| Column   | Type     | Option          |
|----------|----------|-----------------|
|user      |references|foreign_key: true|
|provider  |string    |null: false      |
|uid       |string    |null: false      |
|created_at|datetime  |null: false      |
|updated_at|datetime  |null: false      |

### Association
- belongs_to :user
