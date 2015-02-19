class LinksController < ApplicationController

  before_action :authenticate_user!

  def index
    links = Link.where(user: current_user)

    @data = {
      links: {
        count: links.count,
        opens: OpenAction.count_links(links),
        sells: SellAction.count_links(links),
        commission: SellAction.commission(links),
        eligible_commission: SellAction.eligible_commission(links),
      }
    }

    campaigns = []
    links.group_by(&:campaign).each do |campaign, links|
      campaigns << {
        name: campaign.name,
        links: {
          count: links.count,
          opens: OpenAction.count_links(links),
          sells: SellAction.count_links(links),
          commission: SellAction.commission(links),
          eligible_commission: SellAction.eligible_commission(links),
        },
      }
    end

    @data[:campaigns] = campaigns
  end
end
