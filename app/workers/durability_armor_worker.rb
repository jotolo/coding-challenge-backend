class DurabilityArmorWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'armors'

  def perform(armor_id)
    zombie_armor = ZombieArmor.find_by(id: armor_id)

    zombie_armor&.decrement!(:armor_durability)
  end
end
