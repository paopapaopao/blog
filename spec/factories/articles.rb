FactoryBot.define do
  factory :article do
    name { FFaker::Movie.title }
    body { FFaker::Lorem.paragraph }
    user
  end
end
