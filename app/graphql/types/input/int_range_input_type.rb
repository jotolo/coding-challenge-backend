Types::Input::IntRangeInputType = GraphQL::InputObjectType.define do
  name('IntRangeInput')

  argument :min, types.Int
  argument :max, types.Int
end
