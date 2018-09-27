class Armor < ApplicationRecord
  validates :name, :defense_points, :durability, :price, presence: true
  validates :defense_points, :durability, :price, numericality: { greater_than: 0 }

  has_many :zombie_armors, dependent: :destroy
  has_many :zombies, through: :zombie_armors

end
