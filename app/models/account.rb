class Account < ApplicationRecord
  mount_uploader :icon_image, IconUploader
  mount_uploader :background_image, BackgroundUploader
  belongs_to :user
end
