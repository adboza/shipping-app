class LoadCategoriesController < ApplicationController
  
  def index
    
    @load_categories = LoadCategory.all
  end
 
  
  def new
    @load_category = LoadCategory.new()
  end

  def create    
    @load_category = LoadCategory.new(load_category_params)
    

  end

  private

  def set_load_category
    @load_category = LoadCategory.find(params[:id])
  end
  

  def load_category_params
    params.require(:load_category).permit(:min_weight, :max_weight, :weight_price, :delivery_modality_id)
  end
end