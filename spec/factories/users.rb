FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "testname#{n}"}
    sequence(:password) { |n| "testtest#{n}"}
  end
end