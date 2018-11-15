class User < ApplicationRecord
  require 'open-uri'

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  attr_accessor :profile_image_url

  has_one_attached :avatar
  has_many :favorite_areas, dependent: :destroy
  # 中間テーブルをfavorite_areasという名前にしてしまったため致し方なくlike_areasにした
  has_many :like_areas, through: :favorite_areas, source: :area
  has_many :authentications, dependent: :destroy
  has_many :mokumokus, dependent: :destroy
  has_many :attends, dependent: :destroy
  has_many :attending_mokumokus, through: :attends, source: :mokumoku # 自分の投稿したもくもくを含めない参加予定のもくもく
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  accepts_nested_attributes_for :favorite_areas
  accepts_nested_attributes_for :authentications

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }


  # 自分の投稿したもくもくも含めた参加予定のもくもく
  def attending_including_own
    Mokumoku.attending_of(self)
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

  def update_notification_status(mokumoku)
    notifications_of_mokumoku = notifications.unread.where(notifiable_type: 'Mokumoku')
                                    .where(notifiable_id: mokumoku.id).where(read: :unread)
    notifications_of_mokumoku.each do |notification|
      notification.read!
    end
  end
end
