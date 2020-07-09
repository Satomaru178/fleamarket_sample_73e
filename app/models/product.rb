class Product < ApplicationRecord
  # has_many :user_products, dependent: :destroy
  # has_many :seller, class_name: 'User', through: :user_products
  # has_many :buyer,  class_name: 'User', through: :user_products

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

  validates :condition_id, presence: true,
  numericality: { greater_than: 0, message: "を選択してください" }

  validates :costburden_id, presence: true,
  numericality: { greater_than: 0, message: "を選択してください" }

  validates :shippingorigin_id, presence: true,
  numericality: { greater_than: 0, message: "を選択してください" }

  validates :shippingperiod_id, presence: true,
  numericality: { greater_than: 0, message: "を選択してください" }

  validates :price, presence: true,
  numericality: { greater_than_or_equal_to: 300, less_than: 10_000_000 }

  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  validates :images, presence: true
end
