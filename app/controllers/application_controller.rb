class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    get_role_path
  end

  protected

  def get_role_path
    current_user.merchant? ? campaigns_path : links_path
  end
end
