class CampaignsController < ApplicationController

  before_action :authenticate_user!
  
  respond_to :html, :js

  def index
    @campaigns = Campaign.where(user: current_user).order(:name)
  end

  def new
    @campaign = Campaign.new
  end
  
  def payments
    @campaign = Campaign.find(params[:id])
  end
  
  def codes
    @campaign = Campaign.find(params[:id])
    @sharee_button_html = CGI.escape_html render_to_string 'shared/_sharee_button', layout: false, locals: { campaign: @campaign.id }
    @sharee_thank_html  = CGI.escape_html render_to_string 'shared/_sharee_thank',  layout: false, locals: { code: '[code]', email: '[email]', price: '[price]'}
    @sharee_script_html = CGI.escape_html render_to_string 'shared/_sharee_script', layout: false, locals: { host: 'http://' + request.host_with_port }
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user = current_user
    if @campaign.save
      render :payments
    else
      render :new
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
    @data = {
      link_count: @campaign.links.count,
      open_count: OpenAction.where(link_id: @campaign.links.pluck(:id)).count,
      sell_count: SellAction.where(link_id: @campaign.links.pluck(:id)).count
    }
    sell_actions_group = {}
    @campaign.sell_actions.group_by { |m| m.created_at.beginning_of_month }.each do |time, sell_actions|
      sell_actions_group[time.year] = {}
      sell_actions_group[time.year][time.month] = []
      sell_actions.each do |sell_action|
        sell_actions_group[time.year][time.month] << {
          id: sell_action.id,
          code: sell_action.code,
          email: sell_action.email,
          created_at: sell_action.created_at,
          approved: sell_action.approved_at.present?,
          price: sell_action.price,
          commission_perc: sell_action.commission,
          commission_value: (sell_action.price / 100) * sell_action.commission 
        }
      end
    end
    @data[:sell_actions_group] = sell_actions_group
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update(campaign_params)
      render nothing: true
    else
      render :edit
    end
  end

  def campaign_params
    params.require(:campaign).permit(:name, :url, :commission)
  end
end
