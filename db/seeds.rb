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
  confirmed_at: Time.now.utc,
  admin: true
)

malakas = User.create(
  email: 'malakas@example.com',
  password: :password,
  confirmed_at: Time.now.utc
)
maganda = User.create(
  email: 'maganda@example.com',
  password: :password,
  confirmed_at: Time.now.utc
)

4.times do
  FactoryBot.create(:article, user_id: malakas.id)
  FactoryBot.create(:article, user_id: maganda.id)
end
# or
# FactoryBot.create_list(:article, 4)
