FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
    confirmed_at { DateTime.now }
    approved { true }
  end
end
