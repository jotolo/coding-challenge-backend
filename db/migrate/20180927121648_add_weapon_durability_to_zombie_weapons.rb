class AddWeaponDurabilityToZombieWeapons < ActiveRecord::Migration[5.1]
  def change
    add_column(:zombie_weapons, :weapon_durability, :integer)
  end
end
