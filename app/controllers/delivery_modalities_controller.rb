class DeliveryModalitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :update, :edit]
  def index
    @load_categories = LoadCategory.all
    @delivery_modalities = DeliveryModality.all
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
    @delivery_modality = DeliveryModality.find(params[:id])
    @load_categories = LoadCategory.where(delivery_modality_id: @delivery_modality.id)
    @delivery_modality = DeliveryModality.find(params[:id])
  end
  def edit
    @delivery_modality = DeliveryModality.find(params[:id])
  end
  def update
    @delivery_modality = DeliveryModality.find(params[:id])
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
    params.require(:delivery_modality).permit(:mod_name, :mod_price)
  end
end