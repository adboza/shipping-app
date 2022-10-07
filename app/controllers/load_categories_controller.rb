class LoadCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_user, only: [:new, :create]  
  before_action :set_modality, only: [:new, :create, :show, :edit, :update]  
  before_action :set_load_category, only: [:show, :edit, :update] 
  
  def new    
    @load_category = LoadCategory.new()
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
  
  def edit
    @delivery_modalities = DeliveryModality.all
  end

  def update
    if @load_category.update(load_category_params)
      redirect_to @delivery_modality, notice: 'Preço por peso atualizado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível atualizar o preço por peso'
      render 'edit'
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

def set_modality
  @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
end

def check_user
  if current_user.regular_user? 
    return redirect_to root_path 
  end  
end