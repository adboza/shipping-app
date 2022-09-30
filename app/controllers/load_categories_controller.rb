class LoadCategoriesController < ApplicationController
  #before_action :set_load_category, only: [:show]
  def show  
    @load_category = LoadCategory.find(params[:id])  
  end

  private
  def set_load_category
    @load_category = LoadCategory.find(params[:id])
  end
end