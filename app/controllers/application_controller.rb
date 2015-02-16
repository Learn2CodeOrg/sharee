class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?

  protected

  def configure_devise_params
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :iban, :swift, :paypal, :password, :password_confirmation, :current_password)
    end
  end

  def after_sign_in_path_for(resource)
    get_role_path
  end

  def get_role_path
    current_user.merchant? ? campaigns_path : links_path
  end
end
