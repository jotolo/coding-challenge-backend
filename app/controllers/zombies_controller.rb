class ZombiesController < ApplicationController
  before_action :set_zombie, only: [:show, :update, :destroy, :add_armors, :add_weapons, :eat_brain]

  # GET /zombies
  # GET /zombies?name=theBrainStorm&hit_point=3&&armor_ids[]=3&weapon_ids[]=10.15,17&page=1&per_page=30
  api :GET, '/zombies', 'Return all zombies or search for specific zombies.'
  param :page, Integer, 'Page number you want to list. Default: 1'
  param :per_page, Integer, 'Elements per page you want to list. Default: 30'
  param :name, Integer, 'Search by name.'
  param :hit_points, Integer, 'Search by hit_points.'
  param :speed, Integer, 'Search by speed.'
  param :brains_eaten, Integer, 'Search by brains_eaten.'
  param :turn_date, Date, 'Search by turn_date.'
  param :armor_ids, Array, 'Search zombies who has armors by IDs.'
  param :weapon_ids, Array, 'Search zombies who has weapons by IDs.'
  description 'Return or search for zombies.'
  formats ['json']
  def index
    @zombies = Zombie.search(search_params).paginate(page: params[:page] || 1, per_page: params[:per_page] || 30)
    render json: @zombies
  end

  # GET /zombies/1
  api :GET, '/zombies/1', 'Return an specific zombie'
  param :id, Integer, required: true
  description 'Return an zombie by id.'
  formats ['json']
  def show
    render json: @zombie
  end

  # POST /zombies
  api :POST, '/armors', 'Create an armor'
  param :name, Integer, required: true
  param :hit_points, Integer, required: true
  param :speed, Integer, required: true
  param :brains_eaten, Integer
  param :turn_date, Date, required: true
  param :armor_ids, Array, 'Search zombies who has armors by IDs.'
  param :weapon_ids, Array, 'Search zombies who has weapons by IDs.'
  description 'Create an zombie.'
  error :unprocessable_entity, 'Could not create the zombie.'
  formats ['json']
  def create
    @zombie = Zombie.factory(zombie_params)

    if @zombie.save
      render json: @zombie, status: :created, location: @zombie
    else
      render json: @zombie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /zombies/1
  api :PUT, '/zombies/1', 'Update a zombie'
  param :id, Integer, required: true
  param :name, String
  param :hit_points, Integer
  param :speed, Integer
  param :brains_eaten, Integer
  param :turn_date, Date
  param :armor_ids, Array
  param :weapon_ids, Array
  description 'Update a zombie.'
  error :unprocessable_entity, 'Could not save the zombie.'
  formats ['json']
  def update
    if @zombie.update(zombie_params)
      render json: @zombie
    else
      render json: @zombie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /zombies/1
  api :DELETE, '/zombies/1', 'Destroy a zombie'
  param :id, Integer, required: true
  description 'Destroy an zombie.'
  formats ['json']
  def destroy
    @zombie.destroy
  end

  # POST /zombies/1/add_armors?armor_ids[]=3&armor_ids[]=5
  api :POST, '/zombies/1/add_armors', 'Add armors to zombie'
  param :id, Integer, required: true
  param :armor_ids, Array
  description 'Add armors to zombie.'
  error :unprocessable_entity, 'Could not save the zombie.'
  formats ['json']
  def add_armors
    if (armor_ids = params[:armor_ids])
      armor_ids.each do |armor_id|
        @zombie.zombie_armors.build(armor_id: armor_id)
      end
    end

    if @zombie.save
      render json: @zombie
    else
      render json: @zombie.errors, status: :unprocessable_entity
    end
  end

  # POST /zombies/1/add_weapons?weapon_ids[]=3&weapon_ids[]=5
  api :POST, '/zombies/1/add_weapons', 'Add weapons to zombie'
  param :id, Integer, required: true
  param :weapon_ids, Array
  description 'Add weapons to zombie.'
  error :unprocessable_entity, 'Could not save the zombie.'
  formats ['json']
  def add_weapons
    if (weapon_ids = params[:weapon_ids])
      weapon_ids.each do |weapon_id|
        @zombie.zombie_weapons.build(weapon_id: weapon_id)
      end
    end

    if @zombie.save
      render json: @zombie
    else
      render json: @zombie.errors, status: :unprocessable_entity
    end
  end

  # POST /zombies/1/eat_brain
  api :POST, '/zombies/1/eat_brain', 'Allow zombies to eat brains.'
  param :id, Integer, required: true
  description 'Allow zombies to eat brains.'
  formats ['json']
  def eat_brain
    @zombie.increment!(:brains_eaten)
    render json: @zombie
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_zombie
    @zombie = Zombie.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def zombie_params
    params.require(:zombie).permit(:name, :hit_points, :speed, :brains_eaten, :turn_date, armor_ids: [], weapon_ids: [])
  end

  def search_params
    params.permit(:name, :hit_points, :speed, :brains_eaten, :turn_date, armor_ids: [], weapon_ids: [])
  end
end
