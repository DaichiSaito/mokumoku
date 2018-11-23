class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :mokumoku

  enum read: { unread: false, read: true }
  enum notified_type: { favorite_area_created: 0, commented_to_own_mokumoku: 1, commented_to_attending_mokumoku: 2, attend_mokumoku: 3 }

  scope :recent, -> { order(created_at: :desc).limit(5) }
end
