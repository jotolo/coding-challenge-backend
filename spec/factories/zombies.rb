FactoryBot.define do
  factory :zombie do
    name { "#{Faker::Superhero.prefix} #{Faker::RickAndMorty.character}" }
    hit_points { Faker::Number.between(1, 10) }
    speed { Faker::Number.between(1, 10) }
    brains_eaten { Faker::Number.between(1, 50) }
    turn_date { Faker::Date.between(2.years.ago, Date.today) }
  end
end
