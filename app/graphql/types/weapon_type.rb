Types::WeaponType = GraphQL::ObjectType.define do
  name 'Weapon'
  implements GraphQL::Relay::Node.interface

  field :id, types.ID
  field :name, types.String, 'name of the weapon.'
  field :attack_points, types.Int, 'attack points of the weapon.'
  field :durability, types.Int, 'durability of the weapon.'
  field :price, types.Int, 'price of the weapon.'

  field :zombies, function: Functions::FindZombies.new do
    description 'zombies who has this weapon'
    preload :zombies
  end

  field :zombie_weapons, function: Functions::FindZombieWeapons.new do
    description 'Relation model expressing Zombie-Weapon details, including weapon_durability'
    preload :zombie_weapons
  end

  global_id_field :id
end
