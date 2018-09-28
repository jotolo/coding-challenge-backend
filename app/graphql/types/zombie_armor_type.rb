Types::ZombieArmorType = GraphQL::ObjectType.define do
  name 'ZombieArmor'
  implements GraphQL::Relay::Node.interface

  field :id, types.ID
  field :armor_durability, types.Int, 'Durability of the armor at the time.'
  field :zombie, -> { Types::ZombieType } do
    description 'zombie having the armor.'
    resolve lambda { |obj, _args, _ctx|
      Loaders::RecordLoader.for(Zombie).load(obj.zombie_id)
    }
  end
  field :armor, -> { Types::ArmorType } do
    description 'armor which has the zombie.'
    resolve lambda { |obj, _args, _ctx|
      Loaders::RecordLoader.for(Armor).load(obj.armor_id)
    }
  end

  global_id_field :id
end
