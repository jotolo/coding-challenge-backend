Mutations::Update::UpdateZombieArmor = GraphQL::Relay::Mutation.define do
  name 'UpdateZombieArmor'
  description 'Update a ZombieArmor'

  return_type Types::ZombieArmorType

  input_field :id, !types.ID
  input_field :zombie_id, types.ID
  input_field :armor_id, types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    zombie_armor = ZombieArmor.find(item_id)
    zombie_armor_params = args.to_h.deep_symbolize_keys.slice(:zombie_id, :armor_id)

    zombie_armor.update!(zombie_armor_params)
    zombie_armor
  }
end
