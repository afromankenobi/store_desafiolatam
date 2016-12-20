class AddPaymentServiceToCartPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_payments, :payment_service, :string
  end
end
