Types::ZombieWeaponType = GraphQL::ObjectType.define do
  name 'ZombieWeapon'
  implements GraphQL::Relay::Node.interface

  field :id, types.ID
  field :weapon_durability, types.Int, 'Durability of the weapon at the time.'
  field :zombie, -> { Types::ZombieType } do
    description 'zombie having the weapon.'
    resolve lambda { |obj, _args, _ctx|
      Loaders::RecordLoader.for(Zombie).load(obj.zombie_id)
    }
  end
  field :weapon, -> { Types::WeaponType } do
    description 'weapon which has the zombie'
    resolve lambda { |obj, _args, _ctx|
      Loaders::RecordLoader.for(Weapon).load(obj.weapon_id)
    }
  end

  global_id_field :id
end
