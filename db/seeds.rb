# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  user = User.first || User.create!(name: 'Scott McCormack', email: 'mccormack.scott@gmail.com', password: 'rivoli', password_confirmation: 'rivoli')
end
