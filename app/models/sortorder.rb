class Sortorder < ActiveHash::Base
  self.data = [
    { id: 1, value: "created_at DESC",  name: '出品日時の新しい順' },
    { id: 2, value: "created_at ASC",   name: '出品日時の古い順'   },
    { id: 3, value: "price DESC",       name: '価格の高い順'      },
    { id: 4, value: "price ASC",        name: '価格の安い順'      },
    { id: 5, value: "likes_count DESC", name: 'いいね数の多い順'   },
  ]
end
