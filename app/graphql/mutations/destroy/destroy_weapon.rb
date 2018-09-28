require "#{Rails.root}/lib/helpers.rb"
Mutations::Destroy::DestroyWeapon = GraphQL::Relay::Mutation.define do
  name 'DestroyWeapon'
  description 'Destroy a Weapon'

  return_field :id, types.ID

  input_field :id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    id = Weapon.find(item_id).destroy!.id
    { id: id ? args[:id] : nil }
  }
end
