FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}"}
    sequence(:password) { |n| "testpassword#{n}"}
  end
end