FactoryBot.define do
  factory :zombie_weapon do
    zombie { FactoryBot.create(:zombie) }
    weapon { FactoryBot.create(:weapon) }
  end
end
