class Weapon < ApplicationRecord
  validates :name, :attack_points, :durability, :price, presence: true
  validates :attack_points, :durability, :price, numericality: { greater_than: 0 }

  has_many :zombie_weapons, dependent: :destroy
  has_many :zombies, through: :zombie_weapons

  def self.factory(params)
    zombie_id = params.delete(:zombie_id)

    new_weapon = Weapon.new(params)
    new_weapon.zombie_weapons.build(zombie_id: zombie_id) if zombie_id

    new_weapon
  end
end
