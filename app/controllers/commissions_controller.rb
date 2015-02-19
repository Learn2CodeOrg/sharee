class CommissionsController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
    user = current_user
    links = Link.where(user: user)

    sell_action_ids = SellAction.where(link_id: links, claimed_at: nil, paid_at: nil).where('approved_at IS NOT NULL').pluck(:id)
    session[:sell_action_ids] = sell_action_ids

    @commission = SellAction.where(id: sell_action_ids).sum('price * (commission/100)')
    session[:commission] = @commission
  end

  def pay
    sell_action_ids = session[:sell_action_ids]
    SellAction.where(id: sell_action_ids).update_all({claimed_at: Time.now})
    session.delete(:sell_action_ids)

    commission = session[:commission]
    user = current_user
    UserMailer.claim_email(user, commission.to_s).deliver_later
    ShareeMailer.claim_email(user, commission.to_s).deliver_later
    session.delete(:commission)
  end
end
