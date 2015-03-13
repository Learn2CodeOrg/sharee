class CommissionsController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @user = current_user
    @payoff_day = 8
    @is_payoff_day = Time.now.day >= @payoff_day

    links = Link.where(user: @user)
    sell_action_ids = SellAction.where(link_id: links, claimed_at: nil, paid_at: nil).where('approved_at IS NOT NULL').pluck(:id)

    @commission = SellAction.where(id: sell_action_ids).sum('price * (commission/100)')
    @commission_bottom_limit = 50
    @is_commission_bottom_limit_met = @commission > @commission_bottom_limit

    session[:sell_action_ids] = sell_action_ids
    session[:commission] = @commission
  end

  def pay
    user = current_user
    commission = session[:commission]
    sell_action_ids = session[:sell_action_ids]
    payment_method = params[:payment_method]

    SellAction.where(id: sell_action_ids).update_all(
      {
        claimed_at: Time.now,
        iban: user.iban,
        payment_method: payment_method,
      })
    UserMailer.claim_email(user, commission.to_s).deliver_later
    ShareeMailer.claim_email(user, commission.to_s).deliver_later

    session.delete(:sell_action_ids)
    session.delete(:commission)
  end
end
