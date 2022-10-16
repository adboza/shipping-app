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
    @delivey_modality = DeliveryModality.find(params[:delivery_modality_id])
    @service_order = ServiceOrder.find(params[:service_order_id])
    shipping_order_params = params.require(:shipping_order).permit(:service_order_id, :delivery_modality_id)
    @service_order.shipping_orders.new(shipping_order_params)
    
    #@shipping_order.set_hidden_params(@delivery_modality,@service_order)
    if @service_order.save
      
      redirect_to @service_order, notice: 'Ordem de entrega inicializada com sucesso!' 
    else
      render 'new'
    end  
  end

  private

  def check_regular_user
    if current_user.admin_user? 
      return redirect_to root_path 
    end
  end
  
end