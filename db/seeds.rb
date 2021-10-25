# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: 'admin@example.com',
  password: :password,
  confirmed_at: DateTime.now,
  admin: true,
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
  FactoryBot.create(:article, user_id: nightking.id)
  FactoryBot.create(:comment, user_id: nightking.id, article_id: Article.last.id)
  FactoryBot.create(:comment, user_id: drogon.id, article_id: Article.last.id)

  FactoryBot.create(:article, user_id: drogon.id)
  FactoryBot.create(:comment, user_id: nightking.id, article_id: Article.last.id)
  FactoryBot.create(:comment, user_id: drogon.id, article_id: Article.last.id)
end
# or
# FactoryBot.create_list(:article, 4)
