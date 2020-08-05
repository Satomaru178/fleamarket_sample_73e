class Account < ApplicationRecord
  belongs_to :user
  mount_uploader :icon_image, IconUploader
  mount_uploader :background_image, BackgroundUploader
end
