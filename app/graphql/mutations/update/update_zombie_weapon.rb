Mutations::Update::UpdateZombieWeapon = GraphQL::Relay::Mutation.define do
  name 'UpdateZombieWeapon'
  description 'Update a ZombieWeapon'

  return_type Types::ZombieWeaponType

  input_field :id, !types.ID
  input_field :zombie_id, types.ID
  input_field :weapon_id, types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    zombie_weapon = ZombieWeapon.find(item_id)
    zombie_weapon_params = args.to_h.deep_symbolize_keys.slice(:zombie_id, :weapon_id)

    zombie_weapon.update!(zombie_weapon_params)
    zombie_weapon
  }
end
