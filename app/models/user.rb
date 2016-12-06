class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders, through: :carts

  after_create :create_cart

  def actual_cart
    carts.opened.last
  end

  def create_cart
    carts.build(status: 'opened')
    save
  end
end
