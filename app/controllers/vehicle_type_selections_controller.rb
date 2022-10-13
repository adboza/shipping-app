class VehicleTypeSelectionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_user, only: [:new, :create]  
  #before_action :set_modality, only: [:create]
  #before_action :set_vehicle_type, only: [:create] 
  
  def new    
    @vehicle_types = VehicleType.all
    @delivery_modalities = DeliveryModality.all
    @vehicle_type_selection = VehicleTypeSelection.new()
  end

  def create
    @vehicle_type_selection = VehicleTypeSelection.new(vehicle_type_selection_params)
    if @vehicle_type_selection.save
      redirect_to delivery_modalities_path, notice: 'Categoria de veículo incluída na modalidade.'
    else
      @vehicle_types = VehicleType.all
      @delivery_modality = DeliveryModality.all
      flash.now[:notice] = 'Não foi possível cadastrar a categoria de veículo para modalidade'
      render 'new'
    end
  end
  

  private
  

  def vehicle_type_selection_params    
    params.require(:vehicle_type_selection).permit(:vehicle_type_id, :delivery_modality_id)
  end
  
  def set_modality
    @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
    
  end
  def set_vehicle_type
    @vehicle_type = VehicleType.find(params[:vehicle_type_id])
  end
  
  def check_user
    if current_user.regular_user? 
      return redirect_to root_path 
    end  
  end
end
