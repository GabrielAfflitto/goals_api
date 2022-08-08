FactoryBot.define do
 factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.word }
    # goal { create(:goal) }
 end
end
