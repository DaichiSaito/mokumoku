# == Schema Information
#
# Table name: favorite_areas
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  area_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :favorite_area do
    area_id Area.all.sample.id # デフォルトはランダム
  end
end

