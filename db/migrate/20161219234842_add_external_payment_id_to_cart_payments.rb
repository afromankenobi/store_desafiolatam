class AddExternalPaymentIdToCartPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_payments, :external_payment_id, :string
  end
end
