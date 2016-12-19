class CartPayment < ApplicationRecord
  belongs_to :cart

  after_create :close_cart!

  def close_cart!
    cart.close!
  end
end
