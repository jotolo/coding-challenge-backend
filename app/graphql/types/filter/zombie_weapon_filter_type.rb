Types::Filter::ZombieWeaponFilterType = GraphQL::InputObjectType.define do
  name('ZombieWeaponFilter')

  argument :id, types[types.ID]
  argument :zombie_ids, types[types.ID]
  argument :weapon_ids, types[types.ID]
end
