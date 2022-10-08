class DistanceCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_user, only: [:new, :create]
  before_action :set_modality, only: [:new, :create, :show]

  def new
    @distance_category = DistanceCategory.new
  end

  def create
    if @delivery_modality.distance_categories.create!(distance_categories_params)
    #if @distance_category.save
      redirect_to @delivery_modality, notice: 'Preço por distância incluído.'
    else
      @delivery_modality = DeliveryModality.find(params[:delivery_modality_id])
      flash.now[:notice] = 'Não foi possível'
      render 'new'
    end
  end

  def show
    @distance_category = DistanceCategory.find(params[:id])
  end

  private

  def distance_categories_params
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

end