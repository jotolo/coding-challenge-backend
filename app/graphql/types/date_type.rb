Types::DateType = GraphQL::ScalarType.define do
  name 'Date'
  description 'Date as string'

  coerce_input ->(value, _ctx) { value.to_date }
  coerce_result ->(value, _ctx) { value.iso8601 }
end
