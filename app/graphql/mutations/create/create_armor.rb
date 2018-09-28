require "#{Rails.root}/lib/helpers.rb"
Mutations::Create::CreateArmor = GraphQL::Relay::Mutation.define do
  name 'CreateArmor'
  description 'Create a Armor'

  return_type Types::ArmorType

  input_field :name, !types.String
  input_field :defense_points, !types.Int
  input_field :durability, !types.Int
  input_field :price, !types.Int

  resolve lambda { |_obj, args, _ctx|
    armor_params = args.to_h.deep_symbolize_keys.slice(:name, :defense_points, :durability,
                                                       :price)

    Armor.create!(armor_params)
  }
end
