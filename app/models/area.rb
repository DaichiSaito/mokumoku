# == Schema Information
#
# Table name: areas
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tokyo      :boolean          default(TRUE), not null
#

class Area < ApplicationRecord
  has_many :mokumokus
  has_many :favorite_areas, dependent: :destroy
  has_many :users, through: :favorite_areas

  scope :tokyo, -> { where(tokyo: true) }
  scope :not_tokyo, -> { where(tokyo: false) }
end
