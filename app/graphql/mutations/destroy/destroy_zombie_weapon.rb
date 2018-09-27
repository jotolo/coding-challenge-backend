Mutations::Destroy::DestroyZombieWeapon = GraphQL::Relay::Mutation.define do
  name 'DestroyZombieWeapon'
  description 'Destroy a ZombieWeapon'

  return_field :id, types.ID

  input_field :id, !types.ID

  resolve lambda { |_obj, args, _ctx|
    item_id = Helpers.decode_id(args[:id])
    id = ZombieWeapon.find(item_id).destroy!.id
    { id: id ? args[:id] : nil }
  }
end
