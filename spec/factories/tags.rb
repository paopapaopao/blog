FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.word }

    article
  end
end
