class LoadCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  #before_action :check_user, only: [:index]  
  
  def new
    @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
   
    @load_category = LoadCategory.new()
    @load_categories = LoadCategory.where(delivery_modality_id: @delivery_modality.id)
  end

  def create
    @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
    @delivery_modality.load_categories.new(load_category_params)
    if @delivery_modality.save
      redirect_to new_delivery_modality_load_category_path, notice: 'Preço por peso incluído.'
    else
      flash.now[:notice] = 'Houve um erro.'
      render 'new'
    end
  end
  
  private

  def set_load_category
    @load_category = LoadCategory.find(params[:id])
  end
  

  def load_category_params
    params.require(:load_category).permit(:min_weight, :max_weight, :weight_price, :delivery_modality_id)
  end
end

def check_user
  
  if current_user.user_access != {regular_user:5}
    return redirect_to root_path, alert: 'Você não possui este acesso.'
  end
end