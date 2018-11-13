class Attend < ApplicationRecord
  belongs_to :user
  belongs_to :mokumoku

  validates :user_id, uniqueness: { scope: :mokumoku_id }
end
