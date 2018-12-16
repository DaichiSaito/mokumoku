FactoryBot.define do
  factory :user do
    transient do
      favorite_area_id Area.all.sample.id # デフォルトはランダム
    end

    sequence(:email) { |i| "test#{i}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:name) { |i| "testname#{i}" }
    profile 'プロフィールです'
    role 0
    sequence(:screen_name) { |i| "MOKUMOKU#{i}" }

    trait :with_favorite_areas do
      after(:create) do |user, evaluator|
        create(:favorite_area, user: user, area_id: evaluator.favorite_area_id)
      end
    end
  end
end