FactoryBot.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end
  factory :user do
    email
    password {'1234567890'}
    password_confirmation {'1234567890'}
    confirmed_at { Time.now }
  end
end
