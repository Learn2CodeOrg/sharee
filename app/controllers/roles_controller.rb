class RolesController < ApplicationController

  before_action :authenticate_user!

  respond_to :js

  def change
    role = params[:role]

    unless current_user.update_attribute :role, role
      return false
    end

    return render js: "window.location = '#{get_role_path.to_s}'"
  end
end
