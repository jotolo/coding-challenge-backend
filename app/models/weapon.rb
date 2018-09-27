class Weapon < ApplicationRecord
  validates :name, :attack_points, :durability, :price, presence: true
  validates :attack_points, :durability, :price, numericality: { greater_than: 0 }

  has_many :zombie_weapons, dependent: :destroy
  has_many :zombies, through: :zombie_weapons

end
