class LinksController < ApplicationController

  before_action :authenticate_user!

  def index
    links = Link.where(user: current_user)

    @data = {}
    total_commission = 0
    new_total_commission = 0
    campaigns = []

    links.group_by(&:campaign).each do |campaign, links|

      total_commission += SellAction.where(link_id: links).sum('price * (commission/100)')
      new_total_commission += SellAction.where(link_id: links, paid: false).sum('price * (commission/100)')

      campaigns << {
        name: campaign.name,
        links_count: links.count,
        open_count: OpenAction.where(link_id: links).count,
        sell_count: SellAction.where(link_id: links).count,
        commission_count: SellAction.where(link_id: links).sum('price * (commission/100)'),
        new_sell_count: SellAction.where(link_id: links, paid: true).count,
        new_commission_count: SellAction.where(link_id: links, paid: false).sum('price * (commission/100)'),
      }
    end

    @data[:total_commission] = total_commission
    @data[:total_open] = OpenAction.where(link_id: links).count
    @data[:total_sell] = SellAction.where(link_id: links).count
    @data[:new_total_commission] = new_total_commission
    @data[:campaigns] = campaigns
  end
end
