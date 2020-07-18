class Image < ApplicationRecord
  # products

  belongs_to :product, optional: true

  # uploader

  mount_uploader :src, ImageUploader
end
