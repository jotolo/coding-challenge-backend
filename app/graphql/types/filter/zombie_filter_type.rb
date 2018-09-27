Types::Filter::ZombieFilterType = GraphQL::InputObjectType.define do
  name('ZombieFilter')

  argument :id, types[types.ID]
  argument :name, types[types.String]
  argument :hit_points, Types::Input::IntRangeInputType
  argument :brains_eaten, Types::Input::IntRangeInputType
  argument :speed, Types::Input::IntRangeInputType
  argument :turn_date, Types::Input::DateRangeInputType
end
