Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # Zombies
  field :zombies, function: Functions::FindZombies.new do
    description 'Returns all zombies.'
  end

  field :zombie, function: Functions::FindRecord.new(model: Zombie, type: Types::ZombieType) do
    description 'Returns Zombie by ID.'
  end

  # Armors
  field :armors, function: Functions::FindArmors.new do
    description 'Returns all Armors.'
  end

  field :armor, function: Functions::FindRecord.new(model: Armor, type: Types::ArmorType) do
    description 'Returns Armor by ID.'
  end

  # Weapons
  field :weapons, function: Functions::FindWeapons.new do
    description 'Returns all Weapons.'
  end

  field :weapon, function: Functions::FindRecord.new(model: Weapon, type: Types::WeaponType) do
    description 'Returns Weapon by ID.'
  end

  # Zombie Weapons
  field :zombie_weapons, function: Functions::FindZombieWeapons.new do
    description 'Returns all ZombieWeapons '
  end

  field :zombie_weapon, function: Functions::FindRecord.new(model: ZombieWeapon, type: Types::ZombieWeaponType) do
    description 'Returns ZombieWeapon by ID.'
  end

  # Zombie Armors
  field :zombie_armors, function: Functions::FindZombieArmors.new do
    description 'Returns all ZombieWeapons '
  end

  field :zombie_armor, function: Functions::FindRecord.new(model: ZombieArmor, type: Types::ZombieArmorType) do
    description 'Returns ZombieWeapon by ID.'
  end
end
