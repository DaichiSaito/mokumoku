class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one_attached :avatar
  has_many :favorite_areas, dependent: :destroy
  has_many :areas, through: :favorite_areas
  has_many :mokumokus, dependent: :destroy
  has_many :attends, dependent: :destroy
  has_many :attending_mokumokus, through: :attends, source: :mokumoku # 自分の投稿したもくもくを含めない参加予定のもくもく
  accepts_nested_attributes_for :favorite_areas

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 自分の投稿したもくもくも含めた参加予定のもくもく
  def attending_including_own
    Mokumoku.attending_of(self)
  end

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
