FactoryBot.define do
  factory :mokumoku do
    title 'タイトル'
    body '詳細'
    open_at Time.current + 1.day # デフォルトは翌日としておく
    user
    area_id Area.all.sample.id # デフォルトはランダム
  end
end
