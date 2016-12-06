class PaymentsController < ApplicationController
  def create
    cart = Cart.find(params[:cart_id])
    payment = Payment.new(total: cart.total_amount, cart: cart)

    notice =
      if payment.save
        'Pago realizado con exito'
      else
        'Pago fallido'
      end

    redirect_to cart_path(cart), notice: notice
  end
end
