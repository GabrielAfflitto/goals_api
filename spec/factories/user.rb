FactoryBot.define do
 factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 8) }
 end
end
