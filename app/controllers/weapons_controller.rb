class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :update, :destroy]

  # GET /weapons
  # GET /zombies/:zombie_id/weapons
  api :GET, '/weapons', 'Return all weapons'
  api :GET, '/zombies/:zombie_id/weapons', 'Return all weapons belonging to an specific zombie.'
  param :page, Integer, 'Page number you want to list. Default: 1'
  param :per_page, Integer, 'Elements per page you want to list. Default: 30'
  description 'Return all weapons.'
  formats ['json']
  def index
    if params[:zombie_id]
      @weapons = Zombie.find_by_id(params[:zombie_id])&.weapons
    else
      @weapons = Weapon.all
    end

    @weapons = @weapons.paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 30)

    render json: @weapons
  end

  # GET /weapons/1
  # GET /zombies/:zombie_id/weapons/1
  api :GET, '/weapons/1', 'Return a weapon'
  api :GET, '/zombies/:zombie_id/weapons/1', 'Return a weapon belonging to an specific zombie.'
  param :id, Integer, required: true
  description 'Return a weapon.'
  formats ['json']
  def show
    render json: @weapon
  end

  # POST /weapons
  # POST /zombies/:zombie_id/weapons
  api :POST, '/weapons', 'Create an weapon'
  api :POST, '/zombies/:zombie_id/weapons', 'Create an weapon belonging to an specific zombie.'
  param :name, String, required: true
  param :attack_points, Integer, required: true
  param :durability, Integer, required: true
  param :price, Integer, required: true
  description 'Create a weapon.'
  error :unprocessable_entity, 'Could not create the weapon.'
  formats ['json']
  def create
    @weapon = Weapon.factory(weapon_params)

    if @weapon.save
      render json: @weapon, status: :created, location: @weapon
    else
      render json: @weapon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weapons/1
  # PATCH/PUT /zombies/:zombie_id/weapons/1
  api :PUT, '/weapons/1', 'Update an weapon'
  api :PUT, '/zombies/:zombie_id/weapons/1', 'Update an weapon belonging to an specific zombie.'
  param :id, Integer, required: true
  param :name, String
  param :attack_points, Integer
  param :durability, Integer
  param :price, Integer
  description 'Update a weapon.'
  error :unprocessable_entity, 'Could not save the weapon.'
  formats ['json']
  def update
    if @weapon.update(weapon_params)
      render json: @weapon
    else
      render json: @weapon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /weapons/1
  # DELETE /zombies/:zombie_id/weapons/1
  api :DELETE, '/weapons/1', 'Destroy a weapon'
  api :DELETE, '/zombies/:zombie_id/weapons/1', 'Destroy an weapon belonging to an specific zombie.'
  param :id, Integer, required: true
  description 'Destroy an weapon.'
  formats ['json']
  def destroy
    @weapon.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_weapon
    @weapon = Weapon.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def weapon_params
    params.require(:weapon).permit(:name, :attack_points, :durability, :price)
  end
end
