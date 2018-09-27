require "#{Rails.root}/lib/helpers.rb"
Mutations::AddArmorsToZombie = GraphQL::Relay::Mutation.define do
  name 'AddArmorsToZombie'
  description 'Add Armors to Zombie'

  return_type Types::ZombieType

  input_field :zombie_id, !types.ID
  input_field :armor_ids, !types[types.ID]

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    zombie = Zombie.find(item_id)

    args[:armor_ids].each do |armor_id|
      zombie.zombie_armors.build(armor_id: Helpers.decode_id(armor_id))
    end

    zombie.save!
  }
end
