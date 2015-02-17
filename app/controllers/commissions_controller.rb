class CommissionsController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
    links = Link.where(user: current_user)

    sell_action_ids = SellAction.where(link_id: links, paid: false).pluck(:id)
    session[:sell_action_ids] = sell_action_ids

    @commission = SellAction.where(id: sell_action_ids).sum('price * (commission/100)')
  end

  def pay
    sell_action_ids = session[:sell_action_ids]
    SellAction.where(id: sell_action_ids).update_all({paid: true})

    session.delete(:sell_action_ids)
  end
end
