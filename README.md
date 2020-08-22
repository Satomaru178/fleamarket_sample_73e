方針→アピールポイントが分かりやすくて見る気になるREADME（笑）

## :orange_book: フリマアプリ
メルカリを参考に作成したWEBアプリケーションです。<br>
誰でも簡単に売り買いが楽しめるアプリの機能を実装しました。<br>
ユーザー登録、商品出品、商品購入などの機能が再現されていますが、実際の取引はできません。<br>
＋アプリ画像？（仮）考え中<br>
<br>

## :orange_book: 実装した機能
- ユーザー登録・編集機能<br>
- SNS認証による登録、ログイン機能(ローカル環境のみ)<br>
- 商品出品・編集・削除機能<br>
- 商品購入機能（pay.jp）<br>
- カテゴリ機能<br>
- コメント機能<br>
- いいね機能<br>
- 商品検索機能（あいまい検索・詳細検索）<br>
- capistranoによるAWS EC2への自動デプロイ<br>
- ActiveStorageを使用しAWS S3への画像アップロード<br>
<br>

## :orange_book: 本番環境
- URL:    http://54.248.69.170/<br>
- ID:     gundam<br>
- PASS:   0079<br>
<br>

## :orange_book: 使用技術(開発環境)
<a href=""><img src="https://i1.wp.com/qs.nndo.jp/wp-content/uploads/2017/06/ruby.png?fit=393%2C346" height="50px"></a>
　<a href=""><img src="https://job.fellow-s.co.jp/limg/public/wsystem/wp-content/uploads/rails_lo.jpg" height="50px"></a>
　<a href=""><img src="https://cdn-ak.f.st-hatena.com/images/fotolife/o/oasist/20200614/20200614000533.png" height="50px"></a>
　<a href=""><img src="https://livedoor.sp.blogimg.jp/sasata299/imgs/b/d/bdc11dd3.png" height="50px"></a>
Nginx<a href=""><img src="https://www.nginx.co.jp/wp-content/uploads/2020/07/NGINX-Plus_product-page-hero.png" height="50px"></a>
capistrano<a href=""><img src="" height="50px"></a>
haml<a href=""><img src="" height="50px"></a>
sass<a href=""><img src="" height="50px"></a>
jquery<a href=""><img src="" height="50px"></a>
github<a href=""><img src="" height="50px"></a>
AWS(EC2・S3)<a href=""><img src="" height="50px"></a>

devise<a href=""><img src="" height="50px"></a>
rspec<a href=""><img src="" height="50px"></a>
carrierwave<a href=""><img src="" height="50px"></a>
ancestry<a href=""><img src="" height="50px"></a>
payjp<a href=""><img src="" height="50px"></a>
kaminari<a href=""><img src="" height="50px"></a>
<br>
<br>

## :orange_book: 開発体制＆使用ツール<br>
アジャイル開発。2週間ごとにスプリントを設定しました。
- Slack（進捗報告やメンバー間の連絡）<br>
- Trello（タスク管理）<br>
- ZOOM（週2回のMTG）<br>
- スプレッドシート （開発スケジュール、各メンバーの作業時間を把握）<br>
<br>

## :orange_book: Member（Github-link）&担当
#### <a href="https://github.com/Satomaru178">吉村</a><br>
<a href="https://github.com/Satomaru178"><img src="https://avatars2.githubusercontent.com/u/63147677?s=400&u=892b244eb8922295babc96f11011f06b9c4eccb7&v=4" width="50px"></a><br>

#### <a href="https://github.com/osawa4017">大澤</a><br>
<a href="https://github.com/osawa4017"><img src="https://avatars0.githubusercontent.com/u/64793100?s=400&v=4" width="50px"></a><br>

#### <a href="https://github.com/Yuta1634">高橋</a><br>
<a href="https://github.com/Yuta1634"><img src="https://avatars0.githubusercontent.com/u/63214741?s=400&v=4" width="50px"></a><br>

#### <a href="https://github.com/Fyamada1229">山田</a><br>
<a href="https://github.com/Fyamada1229"><img src="https://avatars3.githubusercontent.com/u/54790413?s=400&u=ff241ff28650e2f56fb3c27ec21ddd959ae323c2&v=4" width="50px"></a><br>

#### <a href="https://github.com/kobegoro0930">寺本</a><br>
<a href="https://github.com/kobegoro0930"><img src="https://avatars3.githubusercontent.com/u/62911575?s=460&v=4" width="50px"></a><br>
**フロントエンド**<br>
・ユーザー登録＆ログイン画面<br>
・カテゴリページ（一覧ページ、カテゴリ別ページ）<br>
・TOPページ商品表示<br>
・お気に入りの追加（TOPページ、商品詳細ページ、マイページ）<br>
・README<br>

**バックエンド**<br>
・カテゴリ機能（Ancestry）<br>
・お気に入り機能(javascript)<br>

**工夫したポイント**<br>
ユーザビリティーを意識し、細部にこだわって実装を行いました。<br>
・ユーザー登録ページのプログレスバーの設置<br>
・マイページのいいね一覧ページで条件分岐によるビューの表示変更<br>
・カテゴリ一覧ページでアンカーリンクを設置する<br>
<br>

## :orange_book: 課題や今後実装したい機能
アンケート取るかも<br>
<br>

## :orange_book: ERD

![08_erd_fleamarket_sample_73e](https://user-images.githubusercontent.com/64793100/89715821-8fb48f00-d9e3-11ea-856b-30957a7132b7.png)

<!--
  ユーザ登録時に入力する基本情報。
-->
<br>

## :orange_book: DBテーブル設計
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
- has_one  :point
- has_one  :creditcard
- has_many :products, dependent: :destroy
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :liked_products, through: likes, source: :product

<!--
  ユーザ登録時に登録する基本情報。

  prefectureカラム
  都道府県(プルダウン)
  0          : 未選択
  1-47       : 各都道府県
  48         : 未定
-->
<br>

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

<!--
  マイページでアイコン画像や背景画像を設定できる。
  設定なしだとデフォルトのものにする。
-->
<br>

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

<!--
  クレジットカード情報。
  各ユーザは複数枚のカードを登録できる。

  customer_idカラム
  pay.jpでのuser_id

  card_idカラム
  pay.jpでのcard_id
-->
<br>

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

<!--
  ユーザが買い物したりするとポイントがたまる。
  ポイントは支払いの割引に使える。
-->
<br>

### pointsテーブル
| Column   | Type     | Option                       |
|----------|----------|------------------------------|
|user      |references|null: false, foreign_key: true|
|point     |integer   |null: false, default: 0       |
|created_at|datetime  |null: false                   |
|updated_at|datetime  |null: false                   |
### Association
- belongs_to :user

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

  seller_evaluationカラム
  取引後に売り手と買い手でそれぞれ評価を行う。(ラジオボタン)
  0   : 未評価
  1-5 : 評価

  buyer_evaluationカラム
  取引後に売り手と買い手でそれぞれ評価を行う。(ラジオボタン)
  0   : 未評価
  1-5 : 評価
-->
<br>

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
|seller_evaluation|integer   |default: 0                                                                         |
|buyer_evaluation |integer   |default: 0                                                                         |
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

<!--
  商品の画像。１枚必須。
-->
<br>

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

<!--
  カテゴリーはancestryを使って
  カテゴリー、サブカテゴリー、サブサブカテゴリー、商品、
  という階層構造にする。
-->
<br>

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

<!--
  ブランド名は任意でユーザに入力させる。
  存在しないブランドでも登録できる。
-->
<br>

### brandsテーブル
| Column   | Type   | Option                                                        |
|----------|--------|---------------------------------------------------------------|
|name      |string  |null: false, index: true, unique: true, length: { maximum: 40 }|
|created_at|datetime|null: false                                                    |
|updated_at|datetime|null: false                                                    |
### Association
- has_many :products

<!--
  商品詳細ページでユーザがコメントを残すことができる。
  全てのユーザーが自由にコメントできる。
  出品者は「仮削除」、「完全削除」ができる。
-->
<br>

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

<!--
  商品詳細ページでユーザがいいね！することができる。
  likeカラム
  いいね！フラグ
  false : いいね！していない状態
  true  : いいね！している状態
-->
<br>

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
