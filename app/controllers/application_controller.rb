class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_access])
    devise_parameter_sanitizer.permit(:update, keys: [:name, :user_access])
    devise_parameter_sanitizer.permit(:edit, keys: [:name, :user_access])
  end
end
