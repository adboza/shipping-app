class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  before_action :check_user, only: [:new, :create, :update, :edit]
  before_action :set_service_order,only: [:show, :edit, :update]
  def index
    @service_orders = ServiceOrder.all
  end
  
  def new
    @service_order = ServiceOrder.new()
  end

  def create
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to service_orders_path, notice: 'Ordem de serviço cadastrada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar a ordem de serviço'
      render 'new'
    end
  end

  def search
    @tracking_code = params["query"]    
    @service_orders = ServiceOrder.where("tracking_code LIKE ?", "%#{@tracking_code}%")    
  end

  def show
  end

  def edit
  end

  def update
    @service_order.update(service_order_params)
    redirect_to @service_order, notice: 'Ordem de serviço atualizada com sucesso'
  end

  private

  def check_user
    if current_user.regular_user? 
      return redirect_to root_path 
    end
  end

  def service_order_params    
    params.require(:service_order).permit(:departure_address, :delivery_address, :comments,:shipping_distance, :goods_weight)
  end

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

end