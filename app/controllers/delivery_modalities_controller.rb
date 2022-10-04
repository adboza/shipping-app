class DeliveryModalitiesController < ApplicationController
  def index
    @delivery_modalities = DeliveryModality.all
  end
  def new
    @delivery_motality = DeliveryModality.new
  end
end