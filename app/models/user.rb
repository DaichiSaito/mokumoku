class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one_attached :avatar
  has_many :favorite_areas, dependent: :destroy
  has_many :areas, through: :favorite_areas
  has_many :mokumokus
  accepts_nested_attributes_for :favorite_areas

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def has_mokumoku?(mokumoku)
    mokumokus.include?(mokumoku)
  end
end
