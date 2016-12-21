class DashboardController < ApplicationController
  def index
    @categories =
      Category
      .includes(:products)
      .group(:category_id, 'categories.name')
      .pluck('categories.name, count(products.category_id)')

    @products_by_day = Product.group_by_day(:created_at).count

    @products_by_order =
      Product
      .includes(:orders)
      .group(:name, :product_id)
      .pluck('products.name', 'count(orders.id)')

    @payed_products =
      Product
      .includes(:carts)
      .where(carts: { status: 'closed' })
      .group(:name, :product_id)
      .pluck('products.name', 'count(orders.id)')

    @money_products =
      Product
      .includes(:carts)
      .where(carts: { status: 'closed' })
      .group(:name, :product_id, :price)
      .pluck('products.name', 'sum(products.price)')

    @money_by_day =
      Cart
      .closed
      .group_by_day(:created_at)
      .sum(:total_amount)
  end
end
