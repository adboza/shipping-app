class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :check_user, only: [:new, :create, :update, :edit]
  before_action :set_vehicle, only: [:show, :edit, :update]
  
  def index
    @vehicles = Vehicle.all
    
  end

  def new
    @vehicle = Vehicle.new
    @vehicle_types = VehicleType.all
  end

  def create    
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
    redirect_to vehicles_path, notice: 'Veículo cadastrado com sucesso!'
    else
      @vehicle_types = VehicleType.all
      flash.now[:notice] = 'Não foi possível cadastrar veículo'
      render 'new'
    end
  end

  def show    
  end

  def edit
    @vehicle_types = VehicleType.all
  end

  def update
    @vehicle.update(vehicle_params)
    redirect_to @vehicle, notice: 'Veículo atualizado com sucesso!'
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:licence_plate, :status, :year, :load_capacity, :vehicle_type_id, :model)
  end

  def check_user
    if current_user.regular_user? 
      return redirect_to root_path 
    end
  end
  
  def set_vehicle
    @vehicle_type = VehicleType.find(params[:id])
    @vehicle = Vehicle.find(params[:id])
  end
end
