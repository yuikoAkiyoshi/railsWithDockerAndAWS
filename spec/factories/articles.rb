FactoryBot.define do
    factory :article do
        sequence(:title) { "title" }
        sequence(:body) { "body" }
    end
end