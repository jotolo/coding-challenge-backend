FactoryBot.define do
  factory :zombie_armor do
    zombie { FactoryBot.create(:zombie) }
    armor { FactoryBot.create(:armor) }
  end
end
