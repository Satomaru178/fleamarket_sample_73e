# DBテーブル設計

<!--
  ユーザ登録時に入力する基本情報。
-->

## usersテーブル
| Column               | Type   | Option                               |
|----------------------|--------|--------------------------------------|
|nickname              |string  |null: false, unique: true             |
|email                 |string  |null: false, unique: true, index: true|
|encrypted_password    |string  |null: false                           |
|first_name            |string  |null: false                           |
|last_name             |string  |null: false                           |
|first_name_kana       |string  |null: false                           |
|last_name_kana        |string  |null: false                           |
|birthday              |date    |null: false, default: '1970-01-01'    |
|reset_password_token  |string  |index: true                           |
|reset_password_sent_at|datetime|                                      |
|remember_created_at   |datetime|                                      |

### Association
- has_one  :address
- has_one  :acount
- has_one  :point
- has_many :sold,   class_name: 'Product', through: :users_products
- has_many :bought, class_name: 'Product', through: :users_products
- has_many :comments
- has_many :likes, through: users_likes
- has_many :creditcards
- has_many :users_products
- has_many :users_likes

<!--
  ユーザ登録時に登録する基本情報。

  prefecture:都道府県(プルダウン)
  0:未選択
  1-47:各都道府県
  48:未定
-->

## addressesテーブル
| Column        | Type  | Option                       |
|---------------|-------|------------------------------|
|user_id        |integer|null: false, foreign_key: true|
|first_name     |string |null: false                   |
|last_name      |string |null: false                   |
|first_name_kana|string |null: false                   |
|last_name_kana |string |null: false                   |
|zipcode        |string |null: false                   |
|prefecture     |integer|null: false, default: 0       |
|city           |string |null: false                   |
|address        |string |null: false                   |
|address_other  |string |                              |
|tell           |string |                              |

### Association
- belongs_to :user

<!--
  マイページでアイコン画像や背景画像を設定できる。
  設定なしだとデフォルトのものにする。
-->

## accountsテーブル
| Column         | Type  | Option                       |
|----------------|-------|------------------------------|
|user_id         |integer|null: false, foreign_key: true|
|icon_image      |string |                              |
|background_image|string |                              |

### Association
- belongs_to :user

<!--
  クレジットカード情報。
  各ユーザは複数枚のカードを登録できる。
-->

## creditcardsテーブル
| Column         | Type  | Option                       |
|----------------|-------|------------------------------|
|user_id         |integer|null: false, foreign_key: true|
|number          |string |null: false, unique: true     |
|expiration_year |integer|null: false, default: 2025    |
|expiration_month|integer|null: false, default: 1       |
|security_code   |string |null: false                   |

### Association
- belongs_to :user

<!--
  ユーザが買い物したりするとポイントがたまる。
  ポイントは支払いの割引に使える。
-->

## pointsテーブル
| Column | Type  | Option                       |
|--------|-------|------------------------------|
|user_id |integer|null: false, foreign_key: true|
|point   |integer|null: false, default: 0       |

### Association
- belongs_to :users

<!--
  商品を出品する時に登録する情報。

  condition:商品の状態(プルダウン)
  0:未選択
  1:新品、未使用
  2:未使用に近い
  3:目立った傷や汚れなし
  4:やや傷や汚れあり
  5:傷や汚れあり
  6:全体的に状態が悪い

  cost_burden:送料負担(プルダウン)
  0:未選択
  1:送料込み(出品者負担)
  2:着払い(購入者負担)

  shipping_origin:発送元住所(プルダウン)
  0:未選択
  1-47:各都道府県
  48:未定

  shipping_period:発送までの期間(プルダウン)
  0:未選択
  1:1〜2日で発送
  2:2〜3日で発送
  3:4〜7日で発送

  price:値段。300円〜9,999,999円まで(数値入力)
  299以下:エラー
  300-9,999,999:値段
  10,000,000以上:エラー
-->

## productsテーブル
| Column        | Type  | Option                              |
|---------------|-------|-------------------------------------|
|name           |string |null: false, index: true             |
|explain        |text   |null: false                          |
|category_id    |integer|null: false, foreign_key: true       |
|brand_id       |integer|foreign_key: true                    |
|condition      |integer|null: false, default: 0              |
|cost_burden    |integer|null: false, default: 0              |
|shipping_origin|integer|null: false, default: 0              |
|shipping_period|integer|null: false, default: 0              |
|price          |integer|null: false, default: 0              |

### Association
- belongs_to :category
- belongs_to :bland
- has_many :seller, class_name: 'User', through: :users_products
- has_many :buyer,  class_name: 'User', through: :users_products
- has_many :images
- has_many :comments
- has_many :likes, through: :products_likes
- has_many :users_products
- has_many :products_likes

<!--
  商品の画像。１枚必須。
-->

## imagesテーブル
| Column   | Type  | Option                       |
|----------|-------|------------------------------|
|product_id|integer|null: false, foreign_key: true|
|image     |string |null: false                   |

### Association
- belongs_to :products

<!--
  カテゴリーはancestryを使って
  カテゴリー、サブカテゴリー、サブサブカテゴリー、商品、
  という階層構造にする。
-->

## categoriesテーブル
| Column | Type | Option                 |
|--------|------|------------------------|
|name    |string|null: false, index: true|

### Association
- has_many :products
- has_ancestry

<!--
  ブランド名は任意でユーザに入力させる。
  存在しないブランドでも登録できる。
-->

## brandsテーブル
| Column | Type | Option    |
|--------|------|-----------|
|name    |string|index: true|

### Association
- has_many :products

<!--
  商品詳細ページでユーザがコメントを残すことができる。
-->

## commentsテーブル
| Column   | Type  | Option                       |
|----------|-------|------------------------------|
|writer_id |integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
|comment   |text   |null: false                   |

### Association
- belongs_to :writer, class_name: 'User'
- belongs_to :product

<!--
  商品詳細ページでユーザがいいね！することができる。
  like:いいね！フラグ
  false:いいね！していない状態
  true:いいね！している状態
-->

## likesテーブル
| Column | Type  | Option                    |
|--------|-------|---------------------------|
|like    |boolean|null: false, default: false|

### Association
- has_many :users,    through: :users_likes
- has_many :products, through: users_likes
- has_many :users_likes
- has_many :products_likes

<!--
  usersテーブルとproductsテーブルの中間テーブル。

  seller_evaluation:取引後に売り手と買い手でそれぞれ評価を行う。(ラジオボタン)
  0:未評価
  1-5:評価

  buyer_evaluation:取引後に売り手と買い手でそれぞれ評価を行う。(ラジオボタン)
  0:未評価
  1-5:評価
-->

## users_productsテーブル

| Column          | Type  | Option                       |
|-----------------|-------|------------------------------|
|sold_id          |integer|null: false, foreign_key: true|
|seller_id        |integer|null: false, foreign_key: true|
|seller_evaluation|integer|default: 0                    |
|bourght_id       |integer|foreign_key: true             |
|buyer_id         |integer|foreign_key: true             |
|buyer_evaluation |integer|default: 0                    |

### Association
- belogns_to :sold,    class_name: 'Product'
- belongs_to :seller,  class_name: 'User'
- belongs_to :bourght, class_name: 'Product'
- belongs_to :buyer,   class_name: 'User'

<!--
  usersテーブルとlikesテーブルの中間テーブル。
-->

## users_likesテーブル
| Column | Type  | Option                       |
|--------|-------|------------------------------|
|user_id |integer|null: false, foreign_key: true|
|like_id |integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :like

<!--
  productsテーブルとlikesテーブルの中間テーブル。
-->

## products_likesテーブル
| Column   | Type  | Option                       |
|----------|-------|------------------------------|
|product_id|integer|null: false, foreign_key: true|
|like_id   |integer|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :like
