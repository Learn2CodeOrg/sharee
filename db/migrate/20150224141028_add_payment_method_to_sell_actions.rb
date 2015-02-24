class AddPaymentMethodToSellActions < ActiveRecord::Migration
  def change
    add_column :sell_actions, :payment_method, :integer
  end
end
