FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    introduction { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end