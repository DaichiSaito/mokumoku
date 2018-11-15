class User < ApplicationRecord
  require 'open-uri'
  require 'securerandom'

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  attr_accessor :profile_image_url

  has_one_attached :avatar
  has_many :favorite_areas, dependent: :destroy
  has_many :areas, through: :favorite_areas
  has_many :authentications, dependent: :destroy
  has_many :mokumokus, dependent: :destroy
  has_many :attends, dependent: :destroy
  has_many :attending_mokumokus, through: :attends, source: :mokumoku
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validate :favorite_areas_count

  def avatar_or_default
    avatar.attached? ? avatar : 'sample.jpg'
  end

  def download_and_attach_avatar
    return unless avatar_image_url

    file = open(avatar_image_url)
    avatar.attach(io: file,
                  filename: "profile_image.#{file.content_type_parse.first.split("/").last}",
                  content_type: file.content_type_parse.first)
  end

  def avatar_image_url
    profile_image_url&.gsub(/_normal/, '')
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

  def post_comment(mokumoku, comment)
    comment.user_id = id
    comment.mokumoku_id = mokumoku.id
    comment.save
  end

  def has_comment?(comment)
    comments.include?(comment)
  end
  
  def assign_password
    pass = SecureRandom.base64(8)
    assign_attributes(password: pass, password_confirmation: pass)
  end

  private

  def favorite_areas_count
    errors.add('お気に入りエリア', "を１つ以上指定して下さい") if favorite_areas.size < 1
  end
end
