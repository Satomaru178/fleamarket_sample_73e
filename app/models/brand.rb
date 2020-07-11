class Brand < ApplicationRecord
  has_many :products

  validates :name, presence: true, length: { maximum: 40 }
end
