Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  # Zombies
  field :create_zombie, Mutations::Create::CreateZombie.field
  field :update_zombie, Mutations::Update::UpdateZombie.field
  field :destroy_zombie, Mutations::Destroy::DestroyZombie.field

  # Armors
  field :create_armor, Mutations::Create::CreateArmor.field
  field :update_armor, Mutations::Update::UpdateArmor.field
  field :destroy_armor, Mutations::Destroy::DestroyArmor.field

  # Weapons
  field :create_weapon, Mutations::Create::CreateWeapon.field
  field :update_weapon, Mutations::Update::UpdateWeapon.field
  field :destroy_weapon, Mutations::Destroy::DestroyWeapon.field

  # Zombie Armors
  field :create_zombie_armor, Mutations::Create::CreateZombieArmor.field
  field :update_zombie_armor, Mutations::Update::UpdateZombieArmor.field
  field :destroy_zombie_armor, Mutations::Destroy::DestroyZombieArmor.field

  # Zombie Weapons
  field :create_zombie_weapon, Mutations::Create::CreateZombieWeapon.field
  field :update_zombie_weapon, Mutations::Update::UpdateZombieWeapon.field
  field :destroy_zombie_weapon, Mutations::Destroy::DestroyZombieWeapon.field

  # Actions
  field :add_armors_to_zombie, Mutations::AddArmorsToZombie.field
  field :add_weapons_to_zombie, Mutations::AddWeaponsToZombie.field
  field :eat_brain, Mutations::EatBrain.field
end
