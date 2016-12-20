class ChangeTotalOnPayments < ActiveRecord::Migration[5.0]
  def change
    change_column :cart_payments, :total, :integer, using: 'total::integer'
  end
end
