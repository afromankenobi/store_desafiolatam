class RenamePaymentsToCartPayments < ActiveRecord::Migration[5.0]
  def change
    rename_table :payments, :cart_payments
  end
end
