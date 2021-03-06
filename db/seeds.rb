# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

User.create(
  email: 'emanpao@yahoo.com',
  password: :password,
  confirmed_at: DateTime.now,
  approved: true
)
User.create(
  email: 'paolo.casugay@gmail.com',
  password: :password,
  confirmed_at: DateTime.now,
  approved: true
)
nightking = User.create(
  email: 'nightking@example.com',
  password: :password,
  confirmed_at: DateTime.now,
  approved: true
)
drogon = User.create(
  email: 'drogon@example.com',
  password: :password,
  confirmed_at: DateTime.now,
  approved: true
)

4.times do
  # FactoryBot.create(:article, user_id: nightking.id)
  # FactoryBot.create(:comment, commenter: nightking.email, user_id: nightking.id, article_id: Article.last.id)
  # FactoryBot.create(:comment, commenter: drogon.email, user_id: drogon.id, article_id: Article.last.id)

  # FactoryBot.create(:article, user_id: drogon.id)
  # FactoryBot.create(:comment, commenter: nightking.email, user_id: nightking.id, article_id: Article.last.id)
  # FactoryBot.create(:comment, commenter: drogon.email, user_id: drogon.id, article_id: Article.last.id)

  Article.create(
    name: [
      Faker::Lorem.unique.sentence(word_count: 4, supplemental: true, random_words_to_add: 8),
      Faker::Lorem.unique.question(word_count: 4, supplemental: false, random_words_to_add: 8)
    ].sample,
    body: Faker::Lorem.paragraph(sentence_count: 16, supplemental: true, random_sentences_to_add: 32),
    user_id: nightking.id
  )
  Comment.create(
    commenter: nightking.email,
    body: Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 8),
    user_id: nightking.id,
    article_id: Article.last.id
  )
  Comment.create(
    commenter: drogon.email,
    body: Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 8),
    user_id: drogon.id,
    article_id: Article.last.id
  )

  Article.create(
    name: [
      Faker::Lorem.unique.sentence(word_count: 4, supplemental: true, random_words_to_add: 8),
      Faker::Lorem.unique.question(word_count: 4, supplemental: false, random_words_to_add: 8)
    ].sample,
    body: Faker::Lorem.paragraph(sentence_count: 16, supplemental: true, random_sentences_to_add: 32),
    user_id: drogon.id
  )
  Comment.create(
    commenter: nightking.email,
    body: Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 8),
    user_id: nightking.id,
    article_id: Article.last.id
  )
  Comment.create(
    commenter: drogon.email,
    body: Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 8),
    user_id: drogon.id,
    article_id: Article.last.id
  )
end
# or
# FactoryBot.create_list(:article, 4)
