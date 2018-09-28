require "#{Rails.root}/lib/helpers.rb"
Mutations::AddWeaponsToZombie = GraphQL::Relay::Mutation.define do
  name 'AddWeaponsToZombie'
  description 'Add Weapons to Zombie'

  return_type Types::ZombieType

  input_field :zombie_id, !types.ID
  input_field :weapon_ids, !types[types.ID]

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    zombie = Zombie.find(item_id)

    args[:weapon_ids].each do |weapon_id|
      zombie.zombie_weapons.build(weapon_id: Helpers.decode_id(weapon_id))
    end

    zombie.save!
  }
end
