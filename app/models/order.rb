class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  has_one :user, through: :cart
end
