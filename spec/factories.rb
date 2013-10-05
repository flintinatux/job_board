FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :board do
    sequence(:subdomain)  { |n| "board-#{n}" }
    sequence(:title)      { |n| "Job Board #{n}" }
    sequence(:tagline)    { |n| "Everybody likes to post on Job Board #{n}!" }
  end
end
