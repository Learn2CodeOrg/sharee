class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?

  protected

  def configure_devise_params
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :email,
        :password,
        :password_confirmation,
        :current_password,
        :billing_contact,
        :iban,
        
        billing_info_attributes: [
          :billing_contact,
          :address_line_1,
          :address_line_2,
          :zip_code,
          :city,
          :state,
          :company_identification_number,
          :tax_identification_number,
          :vat_identification_number,
        ])
    end
  end

  def after_sign_in_path_for(resource)
    get_role_path
  end

  def get_role_path
    current_user.merchant? ? campaigns_path : links_path
  end
end
