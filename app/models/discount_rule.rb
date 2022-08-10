class DiscountRule < ApplicationRecord
  validates :discounted_price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :discount_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :watch
end
