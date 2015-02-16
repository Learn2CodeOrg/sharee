class AddIbanAndSwiftAndPaypalToUser < ActiveRecord::Migration
  def change
    add_column :users, :iban, :string
    add_column :users, :swift, :string
    add_column :users, :paypal, :string
  end
end
