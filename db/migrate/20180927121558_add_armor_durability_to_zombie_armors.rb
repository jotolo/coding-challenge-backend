class AddArmorDurabilityToZombieArmors < ActiveRecord::Migration[5.1]
  def change
    add_column(:zombie_armors, :armor_durability, :integer)
  end
end
