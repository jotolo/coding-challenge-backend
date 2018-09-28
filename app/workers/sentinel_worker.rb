class SentinelWorker
  include Sidekiq::Worker

  def perform
    # Checking Zombie Armors
    ZombieArmor.find_each(batch_size: 50) do |zombie_armor|
      zombie_armor.armor_durability <= 0 ? zombie_armor.destroy : DurabilityArmorWorker.perform_async(zombie_armor.id)
    end

    # Checking Zombie Weapons
    ZombieWeapon.find_each(batch_size: 50) do |zombie_weapon|
      zombie_weapon.weapon_durability <= 0 ? zombie_weapon.destroy : DurabilityWeaponWorker.perform_async(zombie_weapon.id)
    end
  end
end
