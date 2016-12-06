class Product < ApplicationRecord
  has_many :orders
  has_many :carts, through: :orders
  belongs_to :category
end
