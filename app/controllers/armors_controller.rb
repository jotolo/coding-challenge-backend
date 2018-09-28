class ArmorsController < ApplicationController
  before_action :set_armor, only: [:show, :update, :destroy]

  api :GET, '/armors', 'Return all armors'
  api :GET, '/zombies/:zombie_id/armors', 'Return all armors belonging to an specific zombie.'
  param :page, Integer, 'Page number you want to list. Default: 1'
  param :per_page, Integer, 'Elements per page you want to list. Default: 30'
  description 'Return all armors.'
  formats ['json']
  def index
    @armors = if params[:zombie_id]
                Zombie.find_by_id(params[:zombie_id])&.armors
              else
                Armor.all
              end

    @armors = @armors.paginate(page: params[:page] || 1, per_page: params[:per_page] || 30)

    render json: @armors
  end

  api :GET, '/armors/1', 'Return an specific armors'
  api :GET, '/zombies/:zombie_id/armors/1', 'Return an specific armors belonging to an specific zombie.'
  param :id, Integer, required: true
  description 'Return an armor by id.'
  formats ['json']
  def show
    render json: @armor
  end

  api :POST, '/armors', 'Create an armor'
  api :POST, '/zombies/:zombie_id/armors', 'Create an armor belonging to an specific zombie.'
  param :name, String, required: true
  param :defense_points, Integer, required: true
  param :durability, Integer, required: true
  param :price, Integer, required: true
  description 'Create an armor.'
  error :unprocessable_entity, 'Could not create the armor.'
  formats ['json']
  def create
    @armor = Armor.factory(armor_params)

    if @armor.save
      render json: @armor, status: :created, location: @armor
    else
      render json: @armor.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/armors/1', 'Update an armor'
  api :PUT, '/zombies/:zombie_id/armors/1', 'Update an armor belonging to an specific zombie.'
  param :id, Integer, required: true
  param :name, String
  param :defense_points, Integer
  param :durability, Integer
  param :price, Integer
  description 'Update an armor.'
  error :unprocessable_entity, 'Could not save the armor.'
  formats ['json']
  def update
    if @armor.update(armor_params)
      render json: @armor
    else
      render json: @armor.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/armors/1', 'Destroy an armor'
  api :DELETE, '/zombies/:zombie_id/armors/1', 'Destroy an armor belonging to an specific zombie.'
  param :id, Integer, required: true
  description 'Destroy an armor.'
  formats ['json']
  def destroy
    @armor.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_armor
    @armor = Armor.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def armor_params
    params.require(:armor).permit(:name, :defense_points, :durability, :price)
  end
end
