# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  user = User.first || User.create!(name: 'Scott McCormack', email: 'mccormack.scott@gmail.com', password: 'rivoli', password_confirmation: 'rivoli')

  board = Board.first || Board.create!(subdomain: 'medical', title: 'Medical Jobs', icon: 'icon-user-md', tagline: 'Leading companies of the medical industry have used this job board to find top talent.')

  unless board.categories.any?
    board.categories.create! name: 'nursing'
    board.categories.create! name: 'physician'
  end
end
