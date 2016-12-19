class CartPaymentsController < ApplicationController
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST

  def create
    cart = Cart.find(params[:cart_id])

    payment = Payment.new(
      intent: 'sale',
      payer: {
        payment_method: 'paypal'
      },
      redirect_urls: {
        return_url: done_cart_cart_payments_url(cart),
        cancel_url: cancel_cart_cart_payments_url(cart)
      },
      transactions: [
        {
          amount: {
            total: cart.total_amount,
            currency: 'USD'
          },
          description: "Pago para el carro #{cart.id}"
        }
      ]
    )

    # Create Payment and return the status(true or false)
    if payment.create
      redirect_url = payment.links.find { |v| v.method == 'REDIRECT' }.href
      redirect_to redirect_url
    else
      render json: payment.error # Error Hash
    end
  end

  def done
    payment = Payment.find(params[:paymentId])
    payment.execute(payer_id: params[:PayerID])

    render json: payment
  end

  def cancel
    render json: params.to_json
  end

  def payments
    payments_history = Payment.all

    render json: payments_history.payments.to_json
  end
end
