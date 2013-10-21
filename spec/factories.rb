FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :board do
    sequence(:subdomain)    { |n| "board-#{n}" }
    sequence(:title)        { |n| "Job Board #{n}" }
    sequence(:tagline)      { |n| "Everybody likes to post on Job Board #{n}!" }
    sequence(:suggestions)  { |n| "Job suggestions #{n}!" }
    sequence(:benefits)     { |n| "**You want to post a job on Job Board #{n}.**" }
    sequence(:price)        { 10 + Random.new.rand(390) }
  end

  factory :category do
    association :board
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :job do
    association :category
    sequence(:title)        { |n| "Job #{n}" }
    sequence(:company)      { Faker::Company.name }
    sequence(:location)     { "#{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    sequence(:url)          { Faker::Internet.url }
    sequence(:description)  { |n| "We need someone to do job #{n}." }
    sequence(:instructions) { "Send a resume to #{Faker::Internet.email}" }
    sequence(:email)        { Faker::Internet.email }
  end

  factory :card do
    number '4111111111111111'
    sequence(:month)       { (1..12).to_a.sample }
    sequence(:year)        { Date.today.year + Random.new.rand(15) }
    sequence(:postal_code) { Faker::Address.zip_code }
    sequence(:cvv)         { %w[1 2 3].shuffle.join }
  end
end
