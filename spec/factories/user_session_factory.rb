FactoryGirl.define do
  factory :user_session do
    user
    user_agent { Faker::Lorem.sentence }
    ip { Faker::Internet.ip_v4_address }
  end
end
