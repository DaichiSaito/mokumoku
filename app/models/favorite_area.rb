class FavoriteArea < ApplicationRecord
  belongs_to :user
  belongs_to :area

  def area_name
    Area.find(area_id).name
  end
end
