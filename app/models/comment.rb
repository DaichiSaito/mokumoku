class Comment < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  belongs_to :mokumoku
  has_many :notifications, as: :notifiable, inverse_of: :notifiable, dependent: :destroy

  validates :body, presence: true

  def notification_link
    mokumoku_path(mokumoku.id)
  end
end
