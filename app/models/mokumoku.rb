class Mokumoku < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  belongs_to :area
  has_many :attends, dependent: :destroy
  has_many :participants, through: :attends, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :open_at, presence: true
  validates :area_id, presence: true
  validate :date_cannot_be_in_the_past

  scope :date_range, ->(from, to) { where(open_at: from.beginning_of_day..to.end_of_day) }
  scope :attending_of, ->(user) { where(id: user.attends.select(:mokumoku_id)).or(user.mokumokus) }
  scope :futures, -> { where('open_at >= ?', Date.today) }
  scope :pasts, -> { where('open_at < ?', Date.today) }
  scope :recent_opens, -> { order(open_at: :asc) }

  def date_cannot_be_in_the_past
    # 昨日以前のものはNGとする。時間は見ないので当日であれば許容する。
    if open_at.present? && open_at.to_date <= Date.yesterday
      errors.add(:open_at, '過去の日付は使用できません')
    end
  end

  def share_message
    "タイトル　　　　：#{title}%0A" \
    "もくもく予定日時：#{open_at.to_s(:datetime)}%0A" \
    "エリア　　　　　：#{area.name}"
  end

  def page_url
    "/mokumokus/#{id}"
  end

  def notification_link
    mokumoku_path(id)
  end
end
