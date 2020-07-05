class Product < ApplicationRecord
  has_many :user_products
  has_many :seller, class_name: 'User', through: :user_products
  has_many :buyer,  class_name: 'User', through: :user_products
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :costburden
  belongs_to_active_hash :shippingorigin
  belongs_to_active_hash :shippingperiod
end