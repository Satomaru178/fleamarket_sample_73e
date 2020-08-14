class Comment < ApplicationRecord
  # users
  belongs_to :user

  # products
  belongs_to :product

  # バリデーション
  validates :comment, presence: true
end
