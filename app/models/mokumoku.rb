class Mokumoku < ApplicationRecord
  belongs_to :user
  belongs_to :area

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :open_at, presence: true
  validates :area_id, presence: true
  validate :date_cannot_be_in_the_past

  scope :futures, -> { where('open_at >= ?', Date.today) }

  def date_cannot_be_in_the_past
    # 昨日以前のものはNGとする。時間は見ないので当日であれば許容する。
    if open_at.present? && open_at.to_date <= Date.yesterday
      errors.add(:open_at, '過去の日付は使用できません')
    end
  end
end
