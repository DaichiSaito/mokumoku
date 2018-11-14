class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :mokumoku

  validates :body, presence: true
end
