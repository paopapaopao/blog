FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
    confirmed_at { DateTime.now }
    # or
    # after(:build) { |u| u.skip_confirmation_notification! }
    # after(:create) { |u| u.confirm }
    approved { true }
  end
end
