FactoryBot.define do
  factory :authorization do
    user { nil }
    provider { "github" }
    uid { "654321" }
  end
end
