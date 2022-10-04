class DeliveryModalitiesController < ApplicationController
  def index
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
  end
  private
  
  def delivery_modality_params
    params.require(:delivery_modality).permit(:mod_name, :mod_price)
  end
end