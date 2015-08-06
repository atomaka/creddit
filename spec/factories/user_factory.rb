FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| Faker::Internet.user_name + "#{n}" }
    password { Faker::Internet.password(8, 50) }
    email { Faker::Internet.email }
  end
end
