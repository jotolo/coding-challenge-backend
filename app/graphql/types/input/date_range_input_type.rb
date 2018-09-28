Types::Input::DateRangeInputType = GraphQL::InputObjectType.define do
  name('DateRangeInput')

  argument :from, Types::DateType
  argument :to, Types::DateType
end
