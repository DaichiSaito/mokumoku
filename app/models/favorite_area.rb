# == Schema Information
#
# Table name: favorite_areas
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  area_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FavoriteArea < ApplicationRecord
  belongs_to :user
  belongs_to :area

  def area_name
    Area.find(area_id).name
  end
end
