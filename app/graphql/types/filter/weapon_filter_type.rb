Types::Filter::WeaponFilterType = GraphQL::InputObjectType.define do
  name('WeaponFilter')

  argument :id, types[types.ID]
  argument :name, types[types.String]
  argument :attack_points, Types::Input::IntRangeInputType
  argument :durability, Types::Input::IntRangeInputType
  argument :price, Types::Input::IntRangeInputType
end
