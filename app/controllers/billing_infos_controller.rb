class BillingInfosController < ApplicationController

  before_action :authenticate_user!
  
  respond_to :html, :js

  def update
    @billing_info = BillingInfo.find(params[:id])
    if @billing_info.update(billing_info_params)
      render :update
    end
  end

  private
  def billing_info_params
    params.require(:billing_info).permit(
      :billing_contact,
      :address_line_1,
      :address_line_2,
      :zip_code,
      :city,
      :state,
      :company_identification_number,
      :tax_identification_number,
      :vat_identification_number,
    )
  end
end
