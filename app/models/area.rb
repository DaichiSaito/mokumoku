class Area < ApplicationRecord
  has_many :mokumokus
  has_many :favorite_areas, dependent: :destroy
  has_many :users, through: :favorite_areas
end
