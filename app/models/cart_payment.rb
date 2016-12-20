class CartPayment < ApplicationRecord
  belongs_to :cart

  after_create :close_cart!

  enum status: [:pending, :payed, :canceled]

  def close_cart!
    cart.close!
  end
end
