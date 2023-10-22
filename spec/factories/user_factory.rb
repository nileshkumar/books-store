FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'hello@example.com' }
    password { 'password123' }
  end
end
