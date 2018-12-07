FactoryBot.define do
  factory :favorite_area do
    area_id Area.all.sample.id # デフォルトはランダム
  end
end

