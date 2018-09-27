class AddDefaultValueToBrainsEatenInZombies < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:zombies, :brains_eaten, 0)
  end
end
