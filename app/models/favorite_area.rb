class FavoriteArea < ApplicationRecord
  def area_name
    Area.find(area_id).name
  end
end
