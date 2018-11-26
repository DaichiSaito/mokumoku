# == Schema Information
#
# Table name: comments
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  mokumoku_id :bigint(8)
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

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
