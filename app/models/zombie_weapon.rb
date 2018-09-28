class ZombieWeapon < ApplicationRecord
  belongs_to :zombie
  belongs_to :weapon

  before_create :set_durability

  private

  def set_durability
    self.weapon_durability = weapon.durability || 0
  end
end
