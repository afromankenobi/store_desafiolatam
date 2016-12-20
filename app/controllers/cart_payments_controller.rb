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
      CartPayment.create(
        total: cart.total_amount,
        cart: cart,
        external_payment_id: payment.id, # external payment service reference
        payment_service: 'paypal'
      )
      redirect_url = payment.links.find { |v| v.method == 'REDIRECT' }.href
      redirect_to redirect_url
    else
     render json: payment.error # Error Hash
    end
  end

  def done
    payment = Payment.find(params[:paymentId])
    cart_payment = CartPayment.find_by_external_payment_id(params[:paymentId])

    if payment.execute(payer_id: params[:PayerID])
      cart_payment.status = 'payed'
      if cart_payment.save
        redirect_to root_path, notice: 'Pagado'
      else
        logger.fatal 'Pagado pero no registrado'
        redirect_to root_path, notice: 'Problemas'
      end
    else
      render json: payment.error # Error Hash
    end
  end

  def payments
    payment_history = Payment.all(count: 10)
    render json: payment_history.payments.to_json
  end
end
