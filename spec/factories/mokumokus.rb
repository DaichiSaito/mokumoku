# == Schema Information
#
# Table name: mokumokus
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  area_id    :bigint(8)
#  title      :string           not null
#  body       :text             not null
#  open_at    :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :mokumoku do
    title 'タイトル'
    body '詳細'
    open_at Time.current + 1.day # デフォルトは翌日としておく
    user
    area_id Area.all.sample.id # デフォルトはランダム
  end
end
