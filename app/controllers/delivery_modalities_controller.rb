class DeliveryModalitiesController < ApplicationController
  def index
    @delivery_modalities = DeliveryModality.all
  end
end