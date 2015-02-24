class AddPaymentInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :iban_referer, :string
    add_column :users, :swift_referer, :string
    add_column :users, :paypal_referer, :string

    add_column :users, :iban_merchant, :string
    add_column :users, :swift_merchant, :string
    add_column :users, :paypal_merchant, :string
  end
end
