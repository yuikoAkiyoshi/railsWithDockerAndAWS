FactoryBot.define do
  factory :comment do
    sequence(:comment) { "comment"}
    association :article
    association :user
  end
end