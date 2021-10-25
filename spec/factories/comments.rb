FactoryBot.define do
  factory :comment do
    commenter { Faker::Internet.username }
    body { Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 8) }

    user
    article
  end
end
