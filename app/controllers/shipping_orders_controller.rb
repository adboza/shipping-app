class ShippingOrdersController < ApplicationController
  before_action :check_regular_user, only: [:new, :create]
  def new
    @service_order = ServiceOrder.find(params[:service_order_id])
    @quotations = Quotation.where(service_order: @service_order)
    @shipping_order = ShippingOrder.new
  end

  def create
    @service_order = ServiceOrder.find(params[:service_order_id])
    shipping_order_params = params.require(:shipping_order).permit(:quotation_id)
    if @service_order.create_shipping_order!(shipping_order_params)
    #if @shipping_order.save
      @service_order.shipping_order.update(late_comments: nil)
      redirect_to @service_order, notice: 'Ordem de entrega inicializada com sucesso!' 
    else
      @service_order = ServiceOrder.find(params[:service_order_id])
      flash.now[:notice] = 'Não foi possível cadastrar a ordem de entrega!'
      render 'new'
    end     
  end

  def edit
    @service_order = ServiceOrder.find(params[:service_order_id])
    @shipping_order = ShippingOrder.find(params[:id])
  end

  def update
    @service_order = ServiceOrder.find(params[:service_order_id])
    @shipping_order = ShippingOrder.find(params[:id])
    shipping_order_params = params.require(:shipping_order).permit(:late_comments, :received_date)
    if @shipping_order.update(shipping_order_params)
      redirect_to @service_order, notice: 'Ordem de entrega atualizada com sucesso!'
    else    
      flash.now[:notice] = 'Não foi possível atualizar a ordem de entrega'
      render 'edit'
    end

  end

  private

  def check_regular_user
    if current_user.admin_user? 
      return redirect_to root_path 
    end
  end
  
  

end