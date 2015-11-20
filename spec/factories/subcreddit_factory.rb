FactoryGirl.define do
  factory :subcreddit do
    owner { create(:user) }
    sequence(:name) { |n| Faker::Team.name.first(18) + "#{n}" }
  end
end
