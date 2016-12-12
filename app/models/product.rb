class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :carts, through: :orders
  belongs_to :category
end
