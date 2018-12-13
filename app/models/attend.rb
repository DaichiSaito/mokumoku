# == Schema Information
#
# Table name: attends
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  mokumoku_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Attend < ApplicationRecord
  belongs_to :user
  belongs_to :mokumoku

  validates :user_id, uniqueness: { scope: :mokumoku_id }
end
