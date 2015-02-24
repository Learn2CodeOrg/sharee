class RemoveIbanAndSwiftAndPaypalFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :iban, :string
    remove_column :users, :swift, :string
    remove_column :users, :paypal, :string
  end
end
