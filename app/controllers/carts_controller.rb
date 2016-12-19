class CartsController < ApplicationController
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST

  before_action :authenticate_user!
  def show
    @cart = Cart.find params[:id]
  end
end
