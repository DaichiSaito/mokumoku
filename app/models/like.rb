class Like < ApplicationRecord
  belongs_to :user
  belongs_to :mokumoku

  validates :user_id, presence: true
  validates :mokumoku_id, presence: true
end
