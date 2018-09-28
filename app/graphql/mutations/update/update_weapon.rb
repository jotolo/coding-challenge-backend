require "#{Rails.root}/lib/helpers.rb"
Mutations::Update::UpdateWeapon = GraphQL::Relay::Mutation.define do
  name 'UpdateWeapon'
  description 'Update a Weapon'

  return_type Types::WeaponType

  input_field :id, !types.ID
  input_field :name, types.String
  input_field :attack_points, types.Int
  input_field :durability, types.Int
  input_field :price, types.Int

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    weapon = Weapon.find(item_id)
    weapon_params = args.to_h.deep_symbolize_keys.slice(:name, :attack_points, :durability,
                                                        :price)

    weapon.update!(weapon_params)
    weapon
  }
end
