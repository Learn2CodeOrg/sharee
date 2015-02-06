class CreateOpenActions < ActiveRecord::Migration
  def change
    create_table :open_actions do |t|
      t.integer :link_id

      t.timestamps null: false
    end
  end
end
