class Area < ApplicationRecord
  has_many :mokumokus
  has_many :favorite_areas, dependent: :destroy
  has_many :users, through: :favorite_areas

  scope :tokyo, -> { where(tokyo: true) }
  scope :not_tokyo, -> { where(tokyo: false) }
end
