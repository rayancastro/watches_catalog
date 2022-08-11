class DiscountRule < ApplicationRecord
  validates :bundle_price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bundle_size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :watch
end
