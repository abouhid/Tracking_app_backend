FactoryBot.define do
  factory :measure do
    type { Faker::StarWars.character }
    measurement_id nil
  end
end