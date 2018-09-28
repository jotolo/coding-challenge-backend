class ZombieArmor < ApplicationRecord
  belongs_to :zombie
  belongs_to :armor

  before_create :set_durability

  private

  def set_durability
    self.armor_durability = armor.durability || 0
  end
end
