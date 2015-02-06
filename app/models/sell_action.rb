class SellAction < ActiveRecord::Base
  belongs_to :link

  def self.getOrCreate(code, link_id, email, price)
    sell_action = SellAction.where(code: code).first
    unless sell_action
      sell_action = SellAction.new(code: code, link_id: link_id, email: email, price: price)
      sell_action.save!
    end
    sell_action
  end
end
