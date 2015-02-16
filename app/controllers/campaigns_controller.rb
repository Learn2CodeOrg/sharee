class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.where(user: current_user).order(:name)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user = User.last
    if @campaign.save
      redirect_to @campaign
    else
      render :new
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update(campaign_params)
      redirect_to(@campaign)
    else
      render :edit
    end
  end

  def campaign_params
    params.require(:campaign).permit(:name, :url)
  end
end
