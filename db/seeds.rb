# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  require 'faker'

  user = User.first || User.create!(name: 'Scott McCormack', email: 'mccormack.scott@gmail.com', password: 'rivoli', password_confirmation: 'rivoli')

  board = Board.first || Board.create!(subdomain: 'mccormack', title: 'Medical Jobs', icon: 'icon-user-md', tagline: 'Leading companies of the medical industry have used this job board to find top talent.', suggestions: '"Nurse Practitioner" or "Emergency Medical Technician"', benefits: "**You'll target the cream of the crop.**\nWhere you post your job has a lot to do with the kind of people you'll attract. Our Job Board attracts the best because it's featured on industry-leading sites such as Signal vs. Noise, A List Apart, Zeldman.com, Kottke.org, Coudal.com, and the Ruby on Rails site. People who visit these sites value beautiful design, clean code, and high standards.\n\n**One of a few, not one of many.**\nYou won't have to worry about being a needle in a haystack. We charge more than other job boards to keep supply in check. There are usually less than 200 jobs on our Job Board at any one time. That means your job listing won't get lost in the shuffle like it does at other job sites. Candidates will find you.\n\n**Trusted by industry leaders.**\nIndustry leaders like The New York Times, CNET, Adobe, American Express, NBC, Trek, Skype, Yelp, and Facebook all use the 37signals Job Board to find the best of the best. Many of these brands come back again and again to find new candidates as their hiring needs expand.", price: 400.00)

  unless board.categories.any?
    board.categories.create! name: 'Nursing'
    board.categories.create! name: 'Physician'
  end

  board.categories.each do |category|
    unless category.jobs.any?
      3.times.each do
        category.jobs.create! title: Faker::Company.catch_phrase,
          company:      Faker::Company.name,
          location:     "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
          url:          Faker::Internet.url,
          description:  Faker::Lorem.paragraphs(3).join("\n"),
          instructions: Faker::Lorem.paragraph(2),
          email:        Faker::Internet.email,
          highlight:    Random.new.rand < 0.3
      end
    end
  end
end
