class Notification < ApplicationRecord
  belongs_to :admin
  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
end
