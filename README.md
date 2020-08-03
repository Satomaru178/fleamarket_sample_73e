# DBテーブル設計

![07_erd_fleamarket_sample_73e](https://user-images.githubusercontent.com/64793100/87167490-00df2480-c308-11ea-9b44-bb8101feedd0.png)

<!--
  ユーザ登録時に入力する基本情報。
-->

## usersテーブル
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

### Association
- has_one  :address,     dependent: :destroy
- has_one  :acount,      dependent: :destroy
- has_one  :point,       dependent: :destroy
- has_many :products,    dependent: :destroy
- has_many :comments,    dependent: :destroy
- has_many :likes,       dependent: :destroy
- has_many :creditcards, dependent: :destroy

<!--
  ユーザ登録時に登録する基本情報。

  prefectureカラム
  都道府県(プルダウン)
  0          : 未選択
  1-47       : 各都道府県
  48         : 未定
-->

## addressesテーブル
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
|tell           |string    |                       |

### Association
- belongs_to :user, optional: true

<!--
  マイページでアイコン画像や背景画像を設定できる。
  設定なしだとデフォルトのものにする。
-->

## accountsテーブル
| Column         | Type     | Option                       |
|----------------|----------|------------------------------|
|user            |references|null: false, foreign_key: true|
|icon_image      |string    |                              |
|background_image|string    |                              |
|introduction    |text      |                              |

### Association
- belongs_to :user

<!--
  クレジットカード情報。
  各ユーザは複数枚のカードを登録できる。

  customer_idカラム
  pay.jpでのuser_id

  card_idカラム
  pay.jpでのcard_id
-->

## creditcardsテーブル
| Column    | Type     | Option                       |
|-----------|----------|------------------------------|
|user       |references|null: false, foreign_key: true|
|customer_id|string    |null: false                   |
|card_id    |string    |null: false                   |

### Association
- belongs_to :user

<!--
  ユーザが買い物したりするとポイントがたまる。
  ポイントは支払いの割引に使える。
-->

## pointsテーブル
| Column | Type     | Option                       |
|--------|----------|------------------------------|
|user    |references|null: false, foreign_key: true|
|point   |integer   |null: false, default: 0       |

### Association
- belongs_to :user

<!--
  商品を出品する時に登録する情報。

  condition_idカラム
  商品の状態(activehashによるプルダウン)
  0 : 未選択
  1 : 新品、未使用
  2 : 未使用に近い
  3 : 目立った傷や汚れなし
  4 : やや傷や汚れあり
  5 : 傷や汚れあり
  6 : 全体的に状態が悪い

  costburden_idカラム
  送料負担(activehashによるプルダウン)
  0 : 未選択
  1 : 送料込み(出品者負担)
  2 : 着払い(購入者負担)

  shippingorigin_idカラム
  発送元住所(activehashによるプルダウン)
  0    : 未選択
  1-47 : 各都道府県
  48   : 未定

  shippingperiod_idカラム
  発送までの期間(activehashによるプルダウン)
  0 : 未選択
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

## productsテーブル
| Column          | Type     | Option                                       |
|-----------------|----------|----------------------------------------------|
|seller           |references|null: false, foreign_key: { to_table: :users }|
|buyer            |references|             foreign_key: { to_table: :users }|
|category         |references|null: false, foreign_key: true                |
|brand            |references|             foreign_key: true                |
|name             |string    |null: false, index: true                      |
|explain          |text      |null: false                                   |
|condition_id     |integer   |null: false, default: 0                       |
|costburden_id    |integer   |null: false, default: 0                       |
|shippingorigin_id|integer   |null: false, default: 0                       |
|shippingperiod_id|integer   |null: false, default: 0                       |
|price            |integer   |null: false, default: 0                       |
|seller_evaluation|integer   |             default: 0                       |
|buyer_evaluation |integer   |             default: 0                       |

### Association
- accepts_nested_attributes_for :images, allow_destroy: true
- has_many :images,   dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes,    dependent: :destroy
- belongs_to :seller, class_name: 'User'
- belongs_to :buyer,  class_name: 'User', optional: true
- belongs_to :category
- belongs_to :brand
- extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to_active_hash :condition
- belongs_to_active_hash :costburden
- belongs_to_active_hash :shippingorigin
- belongs_to_active_hash :shippingperiod

<!--
  商品の画像。１枚必須。
-->

## imagesテーブル
| Column | Type     | Option                       |
|--------|----------|------------------------------|
|product |references|null: false, foreign_key: true|
|src     |string    |                              |

### Association
- mount_uploader :src, ImageUploader
- belongs_to :product, optional: true

<!--
  カテゴリーはancestryを使って
  カテゴリー、サブカテゴリー、サブサブカテゴリー、商品、
  という階層構造にする。
-->

## categoriesテーブル
| Column | Type | Option                 |
|--------|------|------------------------|
|name    |string|null: false, index: true|
|ancestry|string|             index: true|

### Association
- has_many :products
- has_ancestry

<!--
  ブランド名は任意でユーザに入力させる。
  存在しないブランドでも登録できる。
-->

## brandsテーブル
| Column | Type | Option                  |
|--------|------|-------------------------|
|name    |string|index: true, unique: true|

### Association
- has_many :products

<!--
  商品詳細ページでユーザがコメントを残すことができる。
  全てのユーザーが自由にコメントできる。
  出品者は「仮削除」、「完全削除」ができる。
-->

## commentsテーブル
| Column     | Type     | Option                       |
|------------|----------|------------------------------|
|user        |references|null: false, foreign_key: true|
|product     |references|null: false, foreign_key: true|
|comment     |text      |null: false                   |
|delete_check|integer   |default: 0                    |

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

## likesテーブル
| Column | Type     | Option                       |
|--------|----------|------------------------------|
|user    |references|null: false, foreign_key: true|
|product |references|null: false, foreign_key: true|
|like    |boolean   |null: false, default: false   |

### Association
- belongs_to :user
- belongs_to :product
