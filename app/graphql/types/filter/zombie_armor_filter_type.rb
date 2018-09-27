Types::Filter::ZombieArmorFilterType = GraphQL::InputObjectType.define do
  name('ZombieArmorFilter')

  argument :id, types[types.ID]
  argument :zombie_ids, types[types.ID]
  argument :armor_ids, types[types.ID]
end
