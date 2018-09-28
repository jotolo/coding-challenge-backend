Mutations::Create::CreateZombieWeapon = GraphQL::Relay::Mutation.define do
  name 'CreateZombieWeapon'
  description 'Create a ZombieWeapon'

  return_type Types::ZombieWeaponType

  input_field :zombie_id, !types.ID
  input_field :weapon_id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    zombie_weapon_params = args.to_h.deep_symbolize_keys.slice(:zombie_id, :weapon_id)

    ZombieWeapon.create!(zombie_weapon_params)
  }
end
