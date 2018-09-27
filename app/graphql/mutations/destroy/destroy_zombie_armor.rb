Mutations::Destroy::DestroyZombieArmor = GraphQL::Relay::Mutation.define do
  name 'DestroyZombieArmor'
  description 'Destroy a ZombieArmor'

  return_field :id, types.ID

  input_field :id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    id = ZombieArmor.find(item_id).destroy!.id
    { id: id ? args[:id] : nil }
  }
end
