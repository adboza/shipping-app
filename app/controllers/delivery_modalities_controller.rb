class DeliveryModalitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :update, :edit]
  before_action :set_modality, only: [:show, :edit, :update]

  def index
    @delivery_modalities = DeliveryModality.all
    @load_categories = LoadCategory.all
    @vehicle_type_selections = VehicleTypeSelection.all
    @distance_categories = DistanceCategory.all
  end

  def new
    @delivery_modality = DeliveryModality.new()
  end

  def create
    @delivery_modality = DeliveryModality.new(delivery_modality_params)
    if @delivery_modality.save
      redirect_to delivery_modalities_path, notice: 'Modalidade cadastrada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar a modalidade'
      render 'new'
    end
  end

  def show
    @vehicle_type_selections = VehicleTypeSelection.where(delivery_modality_id: @delivery_modality.id)
    @load_categories = LoadCategory.where(delivery_modality_id: @delivery_modality.id)
    @distance_categories = DistanceCategory.where(delivery_modality_id: @delivery_modality.id)
  end

  def edit
  end

  def update
    @delivery_modality.update(delivery_modality_params)
    redirect_to @delivery_modality, notice: 'Modalidade atualizada com sucesso'
  end

  private

  def check_user
    if current_user.regular_user? 
      return redirect_to root_path 
    end
  end
  
  def delivery_modality_params
    params.require(:delivery_modality).permit(:mod_name, :mod_price, :status)
  end

  def set_modality
    @delivery_modality = DeliveryModality.find(params[:id])
  end
end