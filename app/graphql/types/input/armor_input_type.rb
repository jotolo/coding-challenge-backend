Types::Input::ArmorInputType = GraphQL::InputObjectType.define do
  name('ArmorInput')

  argument :id, types.ID
  argument :name, types.String
  argument :defense_points, types.Int
  argument :durability, types.Int
  argument :price, types.Int
end
