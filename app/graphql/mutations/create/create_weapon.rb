require "#{Rails.root}/lib/helpers.rb"
Mutations::Create::CreateWeapon = GraphQL::Relay::Mutation.define do
  name 'CreateWeapon'
  description 'Create a Weapon'

  return_type Types::WeaponType

  input_field :name, !types.String
  input_field :attack_points, !types.Int
  input_field :durability, !types.Int
  input_field :price, !types.Int

  resolve lambda { |_obj, args, _ctx|
    weapon_params = args.to_h.deep_symbolize_keys.slice(:name, :attack_points, :durability,
                                                        :price)

    Weapon.create!(weapon_params)
  }
end
