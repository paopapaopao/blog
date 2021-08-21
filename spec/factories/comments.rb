FactoryBot.define do
  factory :comment do
    commenter { FFaker::Internet.user_name }
    body { FFaker::Lorem.sentences }
    article
  end
end
