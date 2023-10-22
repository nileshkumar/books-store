FactoryBot.define do
  factory :book do
    user
    sequence(:title) { |n| "Best book ever (#{n})" }
    author { "test_author" }
    publication_date { "2020-01-01" }
  end
end
