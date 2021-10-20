FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    confirmed_at { DateTime.now }
    # or
    # after(:build) { |u| u.skip_confirmation_notification! }
    # after(:create) { |u| u.confirm }

    approved { true }
  end
end
