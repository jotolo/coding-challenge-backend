require "#{Rails.root}/lib/helpers.rb"
Mutations::Destroy::DestroyZombie = GraphQL::Relay::Mutation.define do
  name 'DestroyZombie'
  description 'Destroy a Zombie'

  return_field :id, types.ID

  input_field :id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    id = Zombie.find(item_id).destroy!.id
    { id: id ? args[:id] : nil }
  }
end
