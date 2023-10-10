class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:choice]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :nickname, :bio, :experience, :level, :flags])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :nickname, :bio, :experience, :level, :flags, :avatar])
  end
end
