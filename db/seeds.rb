# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |index|
  User.create({
                  name: "test user",
                  email: "email#{index}@gmail.com",
                  phone_number: "0396548658", language: :en})
end

10.times do |index|
  User.create({
                  name: "test user",
                  email: "email#{index+10}@gmail.com",
                  phone_number: "0396548658", language: :ar})
end


10.times do |index|
  I18n.locale = :en
  message = Message.create({title: "test title#{index}", body: "body#{index}"})
  I18n.locale = :ar
  message.update ({title: "عنوان#{index}", body: "محتوي#{index}"})
end