class AddStatusToCartPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_payments, :status, :integer, default: 0
  end
end
