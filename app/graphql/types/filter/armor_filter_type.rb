Types::Filter::ArmorFilterType = GraphQL::InputObjectType.define do
  name('ArmorFilter')

  argument :id, types[types.ID]
  argument :name, types[types.String]
  argument :defense_points, Types::Input::IntRangeInputType
  argument :durability, Types::Input::IntRangeInputType
  argument :price, Types::Input::IntRangeInputType
end
