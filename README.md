
# DBテーブル構成

  ## usersテーブル
  | Column         | Type | Options                 |
  |----------------|------|-------------------------|
  |nickname        |string|null: false, unique: true|
  |email           |string|null: false, unique: true|
  |password        |string|null: false              |
  |password_confirm|string|null: false              |
  |first_name      |string|null: false              |
  |last_name       |string|null: false              |
  |first_name_kana |string|null: false              |
  |last_name_kana  |string|null: false              |
  |birthday        |date  |null: false              |

  ### Association
  - has_many :comments
  - has_many :likes
  - has_many :from_messages, class_name: "Message", foreign_key: "from_id"
  - has_many :to_messages, class_name: "Message", foreign_key: "to_id"
  - has_many :evaluations
  - has_one  :account
  - has_one  :address
  - has_one  :card
  - has_one  :sales_price
  - has_one  :point

  ## accountsテーブル
  | Column         | Type  | Options                      |
  |----------------|-------|------------------------------|
  |user_id         |integer|null: false, foreign_key: true|
  |icon_image      |string |                              |
  |background_image|string |                              |
  |introduction    |string |                              |

  ### Association
  - belongs_to :user

  ## addressesテーブル 
  | Column        | Type  | Options                      |
  |---------------|-------|------------------------------|
  |user_id        |integer|null: false, foreign_key: true|
  |first_name     |string |null: false                   |
  |last_name      |string |null: false                   |
  |first_name_kana|string |null: false                   |
  |last_name_kana |string |null: false                   |
  |zipcode        |string |null: false                   |
  |prefecture     |integer|null: false                   |
  |city           |string |null: false                   |
  |address        |string |null: false                   |
  |address_other  |string |                              |
  |tell           |integer|                              |

  ### Association
  - belongs_to :user

  ## itemsテーブル
  | Column             | Type  | Options                      |
  |--------------------|-------|------------------------------|
  |buyer_id            |integer|null: false, foreign_key: true|
  |seller_id           |integer|null: false, foreign_key: true|
  |category_id         |integer|null: false, foreign_key: true|
  |name                |string |null: false                   |
  |explanation         |text   |null: false                   |
  |status              |string |null: false                   |
  |delivery_charge_flag|string |null: false                   |
  |delivery_data       |string |null: false                   |
  |price               |integer|null: false                   |
  |delivery_method     |string |null: false                   |

  ### Association
  - belongs_to :category
  - belongs_to :brand
  - has_many   :images
  - has_many   :comments
  - has_many   :likes
  - has_many   :cards
  - has_many   :rooms, class_name: "Message", foreign_key: "room_id"

  ## imagesテーブル
  | Column | Type  | Options                      |
  |--------|-------|------------------------------|
  |item_id |integer|null: false, foreign_key: true|
  |image   |string |null: false                   |

  ### Association
  - belongs_to :item

  ## categoriesテーブル
  | Column | Type | Options   |
  |--------|------|-----------|
  |path    |string|           |
  |name    |string|null: false|

  ### Association
  - has_many :items
  - has_ancestry

  ## blandsテーブル
  | Column | Type | Options   |
  |--------|------|-----------|
  |path    |string|           |
  |name    |string|null: false|

  ### Association
  - has_many :items
  - has_ancestry

  ## commentsテーブル
  | Column | Type  | Options                      |
  |--------|-------|------------------------------|
  |user_id |integer|null: false, foreign_key: true|
  |item_id |integer|null: false, foreign_key: true|
  |comment |text   |null: false                   |

  ### Association
  - belongs_to :user
  - belongs_to :item

  ## likesテーブル
  | Column | Type  | Options                      |
  |--------|-------|------------------------------|
  |user_id |integer|null: false, foreign_key: true|
  |item_id |integer|null: false, foreign_key: true|

  ### Association
  - belongs_to :user
  - belongs_to :item

  ## cardsテーブル
  | Column | Type  | Options                      |
  |--------|-------|------------------------------|
  |user_id |integer|null: false, foreign_key: true|
  |item_id |integer|null: false, foreign_key: true|

  ### Association
  - belongs_to :user
  - belongs_to :item

  ## messagesテーブル
  | Column | Type  | Options                      |
  |--------|-------|------------------------------|
  |from_id |integer|null: false, foreign_key: true|
  |to_id   |integer|null: false, foreign_key: true|
  |room_id |integer|null: false, foreign_key: true|
  |message |text   |null: false                   |

  ### Association
  - belongs_to :from, class_name: "User"
  - belongs_to :to,   class_name: "User"
  - belongs_to :room, class_name: "Item"

  ## sales_pricesテーブル
  | Column | Type     | Options                      |
  |--------|----------|------------------------------|
  |user_id |integer   |null: false, foreign_key: true|
  |price   |integer   |null: false                   |

  ### Association
  - belongs_to :user

  ## pointsテーブル
  | Column | Type  | Options                      |
  |--------|-------|------------------------------|
  |user_id |integer|null: false, foreign_key: true|
  |point   |integer|null: false                   |

  ### Association
  - belongs_to :user

  ## evaluationテーブル
  | Column   | Type  | Options                      |
  |----------|-------|------------------------------|
  |user_id   |integer|null: false, foreign_key: true|
  |seller_id |integer|null: false, foreign_key: true|
  |buyer_id  |integer|null: false, foreign_key: true|
  |comment   |text   |                              |
  |evaluation|integer|null: false                   |

  ### Association
  - belongs_to :user
  - belongs_to :seller, class_name :"User"
  - belongs_to :buyer,  class_name :"User"
