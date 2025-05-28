FactoryBot.define do
  factory :post do
    association :user  
    body { Faker::Lorem.characters(number:10)}
    shop_name { Faker::Company.name }
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    after(:build) do |post|
      post.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/sample.jpg')),
        filename: 'sample.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
  
end