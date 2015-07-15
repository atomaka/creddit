FactoryGirl.define do
  factory :post do
    user
    subcreddit
    title { Faker::Lorem.sentence }
    link ''
    content { Faker::Lorem.paragraph }
  end
end
