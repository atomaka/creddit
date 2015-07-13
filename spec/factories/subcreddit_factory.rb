FactoryGirl.define do
  factory :subcreddit do
    owner { create(:user) }
    name { Faker::Team.name.first(21) } # 21 is the max length...brittle
  end
end
