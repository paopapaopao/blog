FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
  end
end
