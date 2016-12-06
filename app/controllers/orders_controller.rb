class OrdersController < ApplicationController
  def create
    order = Order.new(product: Product.find(params[:product_id]))
    cart = current_user.actual_cart

    cart.orders << order

    notice =
      if cart.save
        'Producto agregado al carro'
      else
        'Problemas al agregar el producto'
      end

    redirect_to products_path, notice: notice
  end
end
