class Mokumoku < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :attends, dependent: :destroy
  has_many :participants, through: :attends, source: :user

  validates :title, presence: true
  validates :body, presence: true
  validates :open_at, presence: true
  validates :area_id, presence: true

  scope :futures, -> { where('open_at > ?', Time.current) }
end
