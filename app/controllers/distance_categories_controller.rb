class DistanceCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :check_user, only: [:new, :create, :edit, :update]
  before_action :set_modality, only: [:new, :create, :show, :edit, :update]
  before_action :set_distance_category, only: [:show, :edit, :update]

  def new
    @distance_category = DistanceCategory.new
  end

  def create
    if @delivery_modality.distance_categories.create!(distance_category_params)
      redirect_to @delivery_modality, notice: 'Preço por distância incluído.'
    else
      @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
      flash.now[:notice] = 'Não foi possível cadastrar os valores informados!'
      render 'new'
    end
  end

  def show    
  end

  def edit    
    @delivery_modalities = DeliveryModality.all
  end

  def update    
    if @distance_category.update(distance_category_params)
      redirect_to @delivery_modality, notice: 'Preço por distância atualizado com sucesso!'
    else   
      flash.now[:notice] = 'Não foi possível atualizar o preço por distância'
      render 'edit'
    end

  end

  private

  def distance_category_params
    params.require(:distance_category).permit(:min_distance, :max_distance, :distance_price, :delivery_modality_id)
  end
  
  def set_modality
    @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
  end
  
  def check_user
    if current_user.regular_user? 
      return redirect_to root_path 
    end  
  end

  def set_distance_category
    @distance_category = @delivery_modality.distance_categories.find(params[:id])
  end

end