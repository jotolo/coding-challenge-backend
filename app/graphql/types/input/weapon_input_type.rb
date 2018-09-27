Types::Input::WeaponInputType = GraphQL::InputObjectType.define do
  name('WeaponInput')

  argument :id, types.ID
  argument :name, types.String
  argument :attack_points, types.Int
  argument :durability, types.Int
  argument :price, types.Int
end
