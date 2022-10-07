class LoadCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_user, only: [:new, :create]  
  before_action :set_modality, only: [:new, :create, :show]  
  before_action :set_load_category, only: [:show] 
  
  def new    
    @load_category = LoadCategory.new()
    #@load_categories = LoadCategory.where(delivery_modality_id: @delivery_modality.id)
  end

  def create
    @delivery_modality.load_categories.new(load_category_params)
    if @delivery_modality.save
      redirect_to new_delivery_modality_load_category_path, notice: 'Preço por peso incluído.'
    else
      
      redirect_to new_delivery_modality_load_category_path, notice: 'Houve um erro.'
    end
  end

  def show
  end
  
  private

  def set_load_category
    @load_category = LoadCategory.find(params[:id])
  end
  

  def load_category_params
    params.require(:load_category).permit(:min_weight, :max_weight, :weight_price, :delivery_modality_id)
  end
end

def set_modality
  @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
end

def check_user
  if current_user.regular_user? 
    return redirect_to root_path 
  end  
end