class ShippingOrdersController < ApplicationController
  before_action :check_regular_user, only: [:new, :create]
  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    @shipping_order = ShippingOrder.new
  end

  def create
    @service_order = ServiceOrder.find(params[:service_order_id])
    shipping_order_params = params.require(:shipping_order).permit(:service_order_id, :delivery_modality_id, :vehicle_id, :load_distance_id, :distance_category_id)
    if @shipping_order.save
      redirect_to @service_order, notice: 'Ordem de entrega inicializada com sucesso!' 
    else
      render 'new', notice: 'Algo deu errado'
    end 
  end

  private

  def check_regular_user
    if current_user.admin_user? 
      return redirect_to root_path 
    end
  end
  
  

end