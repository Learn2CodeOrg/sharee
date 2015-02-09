class AddCommissionToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :commission, :decimal, precision: 8, scale: 2
  end
end
