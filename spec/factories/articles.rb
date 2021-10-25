FactoryBot.define do
  factory :article do
    name do
      [
        Faker::Lorem.unique.sentence(word_count: 4, supplemental: true, random_words_to_add: 8),
        Faker::Lorem.unique.question(word_count: 4, supplemental: false, random_words_to_add: 8)
      ].sample
    end
    body do
      Faker::Lorem.paragraph(sentence_count: 16, supplemental: true, random_sentences_to_add: 32)
    end

    user
  end
end
