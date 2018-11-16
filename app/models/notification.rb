class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  enum read: { unread: false, read: true }
  scope :mokumoku_notifications, ->(mokumoku) { where(notifiable_type: 'Mokumoku').where(notifiable_id: mokumoku.id) }
end
