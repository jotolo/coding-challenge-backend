class DurabilityWeaponWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'weapons'

  def perform(weapon_id)
    zombie_weapon = ZombieWeapon.find_by(id: weapon_id)

    zombie_weapon&.decrement!(:weapon_durability) if zombie_weapon
  end
end
