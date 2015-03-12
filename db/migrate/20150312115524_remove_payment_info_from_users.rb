class RemovePaymentInfoFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :iban_referer, :string
    remove_column :users, :swift_referer, :string
    remove_column :users, :paypal_referer, :string

    remove_column :users, :iban_merchant, :string
    remove_column :users, :swift_merchant, :string
    remove_column :users, :paypal_merchant, :string
  end
end
