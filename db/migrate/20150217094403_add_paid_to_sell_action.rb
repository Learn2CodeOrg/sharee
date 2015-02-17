class AddPaidToSellAction < ActiveRecord::Migration
  def change
    add_column :sell_actions, :paid, :boolean, default: false
  end
end
