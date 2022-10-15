class ShippingOrdersController < ApplicationController
  before_action :check_regular_user, only: [:new, :create]
  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    
    @delivery_modalities = DeliveryModality.all
    @load_categories = LoadCategory.all
    @distance_categories = DistanceCategory.all
    @vehicles = Vehicle.all
    @shipping_order = ShippingOrder.new
    @this_prices_budget = @shipping_order.prices_budget(@service_order)  
  end

  def create
    @service_order = ServiceOrder.find(params[:service_order_id])
    shipping_order_params = params.require(:shipping_order).permit(:service_order_id, :delivery_modality_id)
    @shipping_order = ShippingOrder.new(shipping_order_params)
    @this_prices_budget = @shipping_order.prices_budget(@service_order)
    @shipping_order.set_hidden_params(:delivery_modality_id, @this_prices_budget)
    @shipping_order.save
    redirect_to @service_order, notice: 'Ordem de entrega inicializada com sucesso!'    
  end

  private

  def check_regular_user
    if current_user.admin_user? 
      return redirect_to root_path 
    end
  end
  
end