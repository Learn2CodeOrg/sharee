class AddDatesToSellActions < ActiveRecord::Migration
  def change
    add_column :sell_actions, :approved_at, :timestamp, null: true
    add_column :sell_actions, :charged_at,  :timestamp, null: true
    add_column :sell_actions, :balanced_at, :timestamp, null: true
    add_column :sell_actions, :claimed_at,  :timestamp, null: true
    add_column :sell_actions, :paid_at,     :timestamp, null: true
  end
end
