class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.string :url
      t.string :code

      t.timestamps null: false
    end
  end
end
