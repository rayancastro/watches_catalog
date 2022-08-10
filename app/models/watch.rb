class Watch < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :unit_price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_one :discount_rule
end
