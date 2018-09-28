Types::ArmorType = GraphQL::ObjectType.define do
  name 'Armor'
  implements GraphQL::Relay::Node.interface

  field :id, types.ID
  field :name, types.String, 'Name of the armor.'
  field :defense_points, types.Int, 'Defense Points of the Armor.'
  field :durability, types.Int, 'Durability of the Armor.'
  field :price, types.Int, 'Price of the Armor.'

  field :zombies, function: Functions::FindZombies.new do
    description 'Zombies having this armor.'
    preload :zombies
  end

  field :zombie_armors, function: Functions::FindZombieArmors.new do
    description 'Relation model expressing Zombie-Armor details, including armor_durability'
    preload :zombie_armors
  end

  global_id_field :id
end
