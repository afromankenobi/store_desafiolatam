class Order < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :cart

  has_one :user, through: :cart
end
