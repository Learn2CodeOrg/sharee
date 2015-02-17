class AddCommissionToSellActions < ActiveRecord::Migration
  def change
    add_column :sell_actions, :commission, :decimal, precision: 8, scale: 2
  end
end
