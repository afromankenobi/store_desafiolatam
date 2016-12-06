class Cart < ApplicationRecord
  has_many :orders
  has_many :products, through: :orders
  has_one :payment
  belongs_to :user

  enum status: [:opened, :closed]

  before_save :update_total_amount
  #before_create :set_default_status
  after_save :create_new_cart

  def update_total_amount
    self.total_amount = current_price
  end

  def current_price
    products.map(&:price).sum
  end

  def close!
    self.status = 'closed'
    save
  end

  def create_new_cart
    return if opened?

    user.carts.build().save
  end
end
