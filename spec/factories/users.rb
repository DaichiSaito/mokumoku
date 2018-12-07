FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test#{i}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:name) { |i| "testname#{i}" }
    profile 'プロフィールです'
    role 0
    sequence(:screen_name) { |i| "MOKUMOKU#{i}" }
    after(:create) do |user|
      user.favorite_areas << FactoryBot.create(:favorite_area, user: user)
    end
  end
end
