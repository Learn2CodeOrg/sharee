class LinksController < ApplicationController

  before_action :authenticate_user!

  def index
    @links = Link.where(user: current_user)
  end
end
