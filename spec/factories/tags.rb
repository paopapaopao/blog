FactoryBot.define do
  factory :tag do
    name { FFaker::DizzleIpsum.word }
    article
  end
end
