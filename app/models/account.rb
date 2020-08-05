class Account < ApplicationRecord
  belongs_to :user
  mount_uploader :icon_image, ImageUploader
  mount_uploader :background_image, ImageUploader
end
