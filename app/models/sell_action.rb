class SellAction < ActiveRecord::Base
  belongs_to :link

  before_create :set_approved_at

  delegate :user_email, to: :link, allow_nil: true

  enum payment_method: { transfer: 0, paypal: 1 }

  def self.getOrCreate(code, link, email, price)
    sell_action = SellAction.where(code: code).first
    unless sell_action
      sell_action = SellAction.new(code: code, link_id: link.id, email: email, price: price, commission: link.campaign.commission)
      sell_action.save!
    end
    sell_action
  end

  def self.count_links(links)
    SellAction.where(link_id: links).count
  end

  def self.commission(links)
    SellAction.where(link_id: links).where('approved_at IS NOT NULL').sum('price * (commission/100)')
  end

  def self.eligible_commission(links)
    SellAction.where(link_id: links, claimed_at: nil, paid_at: nil).where('approved_at IS NOT NULL').sum('price * (commission/100)')
  end

  private

  def set_approved_at
    self.approved_at = self.created_at
  end
end
