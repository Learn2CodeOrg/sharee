class AddIbanAndSwiftAndPaypalToSellActions < ActiveRecord::Migration
  def change
    add_column :sell_actions, :iban, :string
    add_column :sell_actions, :swift, :string
    add_column :sell_actions, :paypal, :string
  end
end
