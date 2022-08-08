FactoryBot.define do
 factory :goal do
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
 end
end
