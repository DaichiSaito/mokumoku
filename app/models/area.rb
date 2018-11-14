class Area < ApplicationRecord
  has_many :mokumokus
  has_many :favorite_areas
  has_many :users, through: :favorite_areas
end
