class ShippingOrdersController < ApplicationController
  before_action :check_regular_user, only: [:new, :create]
  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    
    @delivery_modalities = DeliveryModality.all
    @load_categories = LoadCategory.all
    @distance_categories = DistanceCategory.all
    @vehicles = Vehicle.all
    @shipping_order = ShippingOrder.new
    

    
  end

  def create
  end

  private

  def check_regular_user
    if current_user.admin_user? 
      return redirect_to root_path 
    end
  end
end