class SellAction < ActiveRecord::Base
  belongs_to :link

  def self.getOrCreate(code, link, email, price)
    sell_action = SellAction.where(code: code).first
    unless sell_action
      sell_action = SellAction.new(code: code, link_id: link.id, email: email, price: price, commission: link.campaign.commission)
      sell_action.save!
    end
    sell_action
  end

  def pay
    self.paid = true
  end
end
