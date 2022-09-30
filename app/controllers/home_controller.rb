class HomeController < ApplicationController
  def index
    @load_categories = LoadCategory.all
  end  
end