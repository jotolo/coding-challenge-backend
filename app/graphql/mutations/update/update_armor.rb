require "#{Rails.root}/lib/helpers.rb"
Mutations::Update::UpdateArmor = GraphQL::Relay::Mutation.define do
  name 'UpdateArmor'
  description 'Update a Armor'

  return_type Types::ArmorType

  input_field :id, !types.ID
  input_field :name, types.String
  input_field :defense_points, types.Int
  input_field :durability, types.Int
  input_field :price, types.Int

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    armor = Armor.find(item_id)
    armor_params = args.to_h.deep_symbolize_keys.slice(:name, :defense_points, :durability,
                                                       :price)

    armor.update!(armor_params)
    armor
  }
end
