require "#{Rails.root}/lib/helpers.rb"
Mutations::Destroy::DestroyArmor = GraphQL::Relay::Mutation.define do
  name 'DestroyArmor'
  description 'Destroy a Armor'

  return_field :id, types.ID

  input_field :id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    id = Armor.find(item_id).destroy!.id
    { id: id ? args[:id] : nil }
  }
end
