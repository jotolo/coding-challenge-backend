class Zombie < ApplicationRecord
  validates :name, :speed, :turn_date, :hit_points, presence: true

  has_many :zombie_armors, dependent: :destroy, autosave: true
  has_many :armors, through: :zombie_armors

  has_many :zombie_weapons, dependent: :destroy, autosave: true
  has_many :weapons, through: :zombie_weapons

  scope :search, lambda { |params|
    search_scope = all
    search_scope = search_scope.where('LOWER(zombies.name) LIKE LOWER(:name)', name: "%#{params[:name]}%") if params[:name]
    search_scope = search_scope.where(hit_points: params[:hit_points]) if params[:hit_points]
    search_scope = search_scope.where(brains_eaten: params[:brains_eaten]) if params[:brains_eaten]
    search_scope = search_scope.where(speed: params[:speed]) if params[:speed]
    search_scope = search_scope.where(turn_date: params[:turn_date]) if params[:turn_date]
    search_scope = search_scope.joins(zombie_armors: [:armor]).where('armors.id IN (:ids)', ids: params[:armor_ids]) if params[:armor_ids]
    search_scope = search_scope.joins(zombie_weapons: [:weapon]).where('weapons.id IN (:ids)', ids: params[:weapon_ids]) if params[:weapon_ids]
    search_scope
  }

  def self.factory(params)
    armor_ids = params.delete(:armor_ids)
    weapon_ids = params.delete(:weapon_ids)

    new_zombie = Zombie.new(params)

    armor_ids&.each do |armor_id|
      new_zombie.zombie_armors.build(armor_id: armor_id)
    end

    weapon_ids&.each do |weapon_id|
      new_zombie.zombie_weapons.build(weapon_id: weapon_id)
    end

    new_zombie
  end
end
