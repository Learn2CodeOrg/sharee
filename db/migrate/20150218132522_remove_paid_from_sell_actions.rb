class RemovePaidFromSellActions < ActiveRecord::Migration
  def change
    remove_column :sell_actions, :paid, :boolean
  end
end
