Mutations::Create::CreateZombieArmor = GraphQL::Relay::Mutation.define do
  name 'CreateZombieArmor'
  description 'Create a ZombieArmor'

  return_type Types::ZombieArmorType

  input_field :zombie_id, !types.ID
  input_field :armor_id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    zombie_armor_params = args.to_h.deep_symbolize_keys.slice(:zombie_id, :armor_id)

    ZombieArmor.create!(zombie_armor_params)
  }
end
