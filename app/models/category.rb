class Category < ApplicationRecord
  has_many :products
  has_ancestry
  
  validates :name, presence: true, length: { maximum: 40 }

  def set_items
    # 親カテゴリーの場合
    if self.root?
      start_id = self.indirects.first.id
      end_id = self.indirects.last.id
      items = Product.where(category_id: start_id..end_id)
      return items
  
      # 子カテゴリーの場合
    elsif self.has_children?
      start_id = self.children.first.id
      end_id = self.children.last.id
      items = Product.where(category_id: start_id..end_id)
      return items
  
      # 孫カテゴリーの場合
    else
      items = Product.where(category_id: self.id)
      return items
    end
  end
end
