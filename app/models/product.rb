class Product < ApplicationRecord
  # users

  belongs_to :seller, class_name: 'User'
  belongs_to :buyer,  class_name: 'User', optional: true

  # images

  has_many :images, dependent: :destroy

  # activehash

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :costburden
  belongs_to_active_hash :shippingorigin
  belongs_to_active_hash :shippingperiod

  # validation

  validates :name, presence: true, length: { maximum: 40 }

  validates :explain, presence: true, length: { maximum: 1_000 }

  validates :condition_id, :costburden_id, :shippingorigin_id, :shippingperiod_id,
  presence: true, numericality: { greater_than: 0, message: "を選択してください" }

  validates :price, presence: true,
  numericality: { greater_than_or_equal_to: 300, less_than: 10_000_000 }

  validates :seller_id, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  validates :images, presence: true
end
