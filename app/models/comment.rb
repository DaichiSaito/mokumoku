class Comment < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  belongs_to :mokumoku
  has_many :notifications

  validates :body, presence: true, length: { maximum: 400 }

  def notification_link
    mokumoku_path(mokumoku)
  end
end
