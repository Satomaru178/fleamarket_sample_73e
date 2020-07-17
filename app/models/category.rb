class Category < ApplicationRecord
  has_many :products
  has_ancestry
  
  validates :name, presence: true, length: { maximum: 40 }
end
