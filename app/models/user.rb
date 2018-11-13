class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one_attached :avatar
  has_many :favorite_areas, dependent: :destroy
  has_many :areas, through: :favorite_areas
  has_many :mokumokus, dependent: :destroy
  has_many :attends, dependent: :destroy
  has_many :attending_mokumokus, through: :attends, source: :mokumoku
  accepts_nested_attributes_for :favorite_areas

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def has_mokumoku?(mokumoku)
    mokumokus.include?(mokumoku)
  end

  def attending?(mokumoku)
    attending_mokumokus.include?(mokumoku)
  end

  def attend(mokumoku)
    attends.create!(mokumoku_id: mokumoku.id)
  end

  def leave(mokumoku)
    attends.find_by(mokumoku_id: mokumoku.id).destroy!
  end
end
