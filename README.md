# DBテーブル設計

<!--
  ここに解説を書く
-->

## usersテーブル
| Column               | Type   | Option                                            |
|----------------------|--------|---------------------------------------------------|
|nickname              |string  |null: false, unique: true, default: ''             |
|email                 |string  |null: false, unique: true, default: '', index: true|
|encrypted_password    |string  |null: false, default: ''                           |
|first_name            |string  |null: false, default: ''                           |
|last_name             |string  |null: false, default: ''                           |
|first_name_kana       |string  |null: false, default: ''                           |
|last_name_kana        |string  |null: false, default: ''                           |
|birthday              |date    |null: false, default: ’1970-01-01'                 |
|reset_password_token  |string  |index: true                                        |
|reset_password_sent_at|datetime|                                                   |
|remember_created_at   |datetime|                                                   |

### Association
- has_one  :address
- has_one  :acount
- has_many :comments
- has_many :creditcards, through: :users_creditcards
- has_many :evaluations, through: :users_evaluations
- has_many :points,      through: :users_points
- has_many :sold,   class_name: 'Product', through: :histories
- has_many :bought, class_name: 'Product', through: :histories
- has_many :likes,       through: users_likes
- has_many :users_creditcards
- has_many :users_evaluations
- has_many :users_points
- has_many :histories
- has_many :users_likes

<!--
  ここに解説を書く
-->

## addressesテーブル
| Column        | Type  | Option                       |
|---------------|-------|------------------------------|
|user_id        |integer|null: false, foreign_key: true|
|first_name     |string |null: false, default: ''      |
|last_name      |string |null: false, default: ''      |
|first_name_kana|string |null: false, default: ''      |
|last_name_kana |string |null: false, default: ''      |
|zipcode        |string |null: false, default: ''      |
|prefecture     |integer|null: false, default: 0       |
|city           |string |null: false, default: ''      |
|address        |string |null: false, default: ''      |
|address_other  |string |                              |
|tell           |integer|                              |

### Association
- belongs_to :user

<!--
  ここに解説を書く
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
  ここに解説を書く
-->

## creditcardsテーブル
| Column         | Type  | Option                               |
|----------------|-------|--------------------------------------|
|number          |string |null: false, unique: true, default: ''|
|expiration_year |integer|null: false, default: 2025            |
|expiration_month|integer|null: false, default: 1               |
|security_code   |string |null: false, default: ''              |

### Association
- has_many :users_creditcards
- has_many :users, through: :users_creditcards

<!--
  ここに解説を書く
-->

## evaluationsテーブル
| Column          | Type  | Option                |
|-----------------|-------|-----------------------|
|seller_evaluation|integer|null: false, default: 0|
|buyer_evaluation |integer|null: false, default: 0|

### Association
- belongs_to :transaction
- has_many :users_evaluations
- has_many :seller, class_name: 'User', through: :users_evaluations
- has_many :buyer,  class_name: 'User', through: :users_evaluations

<!--
  ここに解説を書く
-->

## pointsテーブル
| Column | Type  | Option                |
|--------|-------|-----------------------|
|point   |integer|null: false, default: 0|

### Association
- has_many :users_points
- has_many :users, through: :users_points

<!--
  ここに解説を書く
-->

## productsテーブル
| Column        | Type  | Option                              |
|---------------|-------|-------------------------------------|
|name           |string |null: false, default: '', index: true|
|explain        |text   |null: false, default: ''             |
|category_id    |integer|null: false, foreign_key: true       |
|brand_id       |integer|foreign_key: true                    |
|condition      |integer|null: false, default: 0              |
|cost_burden    |integer|null: false, default: 0              |
|shipping_origin|integer|null: false, default: 0              |
|shipping_period|integer|null: false, default: 0              |
|price          |integer|null: false, default: 300            |

### Association
- belongs_to :category
- belongs_to :bland
- has_many :seller, class_name: 'User', through: :transactions
- has_many :buyer,  class_name: 'User', through: :transactions
- has_many :images
- has_many :comments
- has_many :likes, through: :products_likes
- has_many :transactions
- has_many :products_likes

<!--
  ここに解説を書く
-->

## imagesテーブル
| Column   | Type  | Option                       |
|----------|-------|------------------------------|
|product_id|integer|null: false, foreign_key: true|
|image     |string |null: false                   |

### Association
- belongs_to :products

<!--
  ここに解説を書く
-->

## categoriesテーブル
| Column | Type | Option                 |
|--------|------|------------------------|
|name    |string|null: false, index: true|

### Association
- has_many :products
- has_ancestry

<!--
  ここに解説を書く
-->

## brandsテーブル
| Column | Type | Option                 |
|--------|------|------------------------|
|name    |string|null: false, index: true|

### Association
- has_many :products

<!--
  ここに解説を書く
-->

## commentsテーブル
| Column   | Type  | Option                       |
|----------|-------|------------------------------|
|writer_id |integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
|comment   |text   |null: false, default: ''      |

### Association
- belongs_to :writer, class_name: 'User'
- belongs_to :product

<!--
  ここに解説を書く
-->

## likesテーブル
| Column | Type  | Option                |
|--------|-------|-----------------------|
|like    |integer|null: false, default: 0|

### Association
- has_many :users,    through: :users_likes
- has_many :products, through: users_likes
- has_many :users_likes
- has_many :products_likes

<!--
  ここに解説を書く
-->

## users_creditcardsテーブル
| Column      | Type  | Option                       |
|-------------|-------|------------------------------|
|user_id      |integer|null: false, foreign_key: true|
|creditcard_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :credit_card

<!--
  ここに解説を書く
-->

## users_evaluationsテーブル
| Column      | Type  | Option                       |
|-------------|-------|------------------------------|
|user_id      |integer|null: false, foreign_key: true|
|evaluation_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :evaluation

<!--
  ここに解説を書く
-->

## users_pointsテーブル
| Column | Type  | Option                       |
|--------|-------|------------------------------|
|user_id |integer|null: false, foreign_key: true|
|point_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :point

<!--
  ここに解説を書く
-->

## historiesテーブル
| Column  | Type  | Option                       |
|---------|-------|------------------------------|
|sold_id  |integer|null: false, foreign_key: true|
|bought_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :sold,   class_name: 'Product'
- belongs_to :bought, class_name: 'Product'

<!--
  ここに解説を書く
-->

## transactionsテーブル
| Column  | Type  | Option                       |
|---------|-------|------------------------------|
|seller_id|integer|null: false, foreign_key: true|
|buyer_id |integer|null: false, foreign_key: true|

### Association
- has_one :evaluation
- belongs_to :seller, class_name: 'User'
- belongs_to :buyer,  class_name: 'User'

<!--
  ここに解説を書く
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
  ここに解説を書く
-->

## products_likesテーブル
| Column   | Type  | Option                       |
|----------|-------|------------------------------|
|product_id|integer|null: false, foreign_key: true|
|like_id   |integer|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :like
