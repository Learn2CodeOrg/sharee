class CreateSellActions < ActiveRecord::Migration
  def change
    create_table :sell_actions do |t|
      t.integer :link_id
      t.string :code
      t.string :email
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
