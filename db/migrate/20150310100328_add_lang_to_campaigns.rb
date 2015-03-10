class AddLangToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :lang, :integer, default: 0
  end
end
