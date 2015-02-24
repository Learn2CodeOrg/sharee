class SellActionsController < ApplicationController

  before_action :authenticate_user!

  respond_to :js

  def set_approve
    id = params[:id]
    approve = params[:approve]

    SellAction.update(id, approved_at: (approve == 'true') ? Time.now : nil)

    return render js: ''
  end
end
