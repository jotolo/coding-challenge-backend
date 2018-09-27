class Armor < ApplicationRecord
  validates :name, :defense_points, :durability, :price, presence: true
  validates :defense_points, :durability, :price, numericality: { greater_than: 0 }

  has_many :zombie_armors, dependent: :destroy
  has_many :zombies, through: :zombie_armors

  def self.factory(params)
    zombie_id = params.delete(:zombie_id)

    new_armor = Armor.new(params)
    if zombie_id
      new_armor.zombie_armors.build(zombie_id: zombie_id)
    end

    new_armor
  end
end
