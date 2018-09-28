Types::ZombieType = GraphQL::ObjectType.define do
  name 'Zombie'
  implements GraphQL::Relay::Node.interface

  field :id, types.ID
  field :name, types.String, 'name of the zombie.'
  field :hit_points, types.Int, 'hit points of the zombie.'
  field :brains_eaten, types.Int, 'brains eaten by zombie.'
  field :speed, types.Int, 'speed of the zombie.'
  field :turn_date, Types::DateType, 'date when the zombie was turned.'

  field :armors, function: Functions::FindArmors.new do
    description "zombie's armors."
    preload :armors
  end

  field :weapons, function: Functions::FindWeapons.new do
    description "zombie's weapons."
    preload :weapons
  end

  field :zombie_armors, function: Functions::FindZombieArmors.new do
    preload :zombie_armors
  end

  field :zombie_weapons, function: Functions::FindZombieWeapons.new do
    preload :zombie_weapons
  end

  global_id_field :id
end
