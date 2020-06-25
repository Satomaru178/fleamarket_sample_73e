# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Test of connection to Remote Repository
大澤です。

# Test of connection to Remote Repository
高橋です。

# Test of connection to Remote Repository
寺本です。

# Test of connection to Remote Repository
吉村でございます。

# Test of connection to Remote Repository
山田です。


# DBテーブル構成
## usersテーブル
| Column | Type | Options |
|--------|------|---------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
|password_confirm|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_kana|string|null: false|
|first_kana|string|null: false|
|birthday|string|null:false|


### Association
 - has_many :likes
 - has_many :from_messages, class_name: "Message", foreign_key: "from_id"
 - has_many :comments
 - has_many :evaluations
 - has_one :address
 - has_one :card
 - has_one :point
 - has_one :account
 - has_one :sales_price

## accountsテーブル
| Columu | Type | Options |
|--------|------|---------|
|user_id|references|foreign_key: true, null: false|
|icon_image|string|       |
|background_image|string| |
|introduction|string|     |  
### Association
 - belongs_to: user

## addressテーブル 
| Column | Type | Options |
|--------|------|---------|
|user_id|references|null: false, foreign_key|
|last_name|string|null: false|
|first_name|string|null: false|
|last_kana|string|null: false|
|first_name|string|null: false|
|postal_code|string|null: false|
|prefectures|integer|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building|string|          |
|phone_number|string|       |

### Association
 - belongs_to: user

## itemsテーブル
| Column | Type | Options |
|--------|------|---------|
|buyer_id|integer|        |
|seller_id|references|integer, null: false|
|category_id|references|null: false, foreign_key: true|
|name|string|null: false|
|explanation|text|null: false|
|status|string|null: false|
|delivery_charge_flag|string|null: false|
|delivery_data|string|null: false|
|price|integer|null: false|
|delivery_method|string|null: false|

### Association
 -  belongs_to :category
 -  belongs_to :brand
 -  has_many :likes
 -  has_many :comment
 -  has_many :images
 -  has_many :messages, class_name: "Message", foreign_key: "room_id"

## imagesテーブル
| Column | Type | Options |
|--------|------|---------|
|item_id|references|null:, foreign_key: true |
|image|string|integer, null: false|

### Association
 -  belongs_to :item

## categoriesテーブル
| Column | Type | Options |
|--------|------|---------|
|path|string|             |
|name|string|  null: false|

### Association
 -  has_many :item
 -  has_ancestry

## commentsテーブル
| Column | Type | Options |
|--------|------|---------|
|user_id|references|null: false, foreign_key|
|item_id|string|null: false, foreign_key|
|text|text|null: false|

### Association
 -  belongs_to:user
 -  belongs:item

## likesテーブル
| Column | Type | Options |
|--------|------|---------|
|user_id|references|null: false, foreign_key|
|item_id|string|null: false, foreign_key|

### Association
 -  belongs_to:user
 -  belongs:item

## cardsテーブル
| Column | Type | Options |
|--------|------|---------|
|user_id|references|null: false, foreign_key|
|item_id|string|null: false, foreign_key|

### Association
 -  belongs_to:user
 -  belongs:item

## messagesテーブル
| Column | Type | Options |
|--------|------|---------|
|from|references|null: false, foreign_key{to_table: users}|
|to|references|null: false, foreign_key{to_table: users}|
|room|references|null: false, foreign_key{to_table: users}|
|message|text|null: false|


### Association
 -  belongs_to :from, class_name: "User"
 -  belongs_to :room, class_name: "Item"

## sales_pricesテーブル
| Column | Type | Options |
|--------|------|---------|
|user|references|null: false,foreign_key: true|
|price|integer|null: false|

### Association
 -  belongs_to :user

## pointsテーブル
| Column | Type | Options |
|--------|------|---------|
|user|references|null: false,foreign_key: true|
|point|integer|null: false|

### Association
 -  belongs_to :user

## evaluationテーブル
| Column | Type | Options |
|--------|------|---------|
|user|references|null: false,foreign_key: true|
|seller|references| null: false, foreign_key: {to_table: users}|
|buyer|references| null: false, foreign_key:{to_table: users}  |
|comment|text|            |
|evaluation|integer|null: false|

### Association
 -  belongs_to :user
 -  belongs_to :seller,class_name :"User"
 -  belongs_to :buyer,class_name :"User"

