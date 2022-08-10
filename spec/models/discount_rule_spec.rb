require 'rails_helper'

RSpec.describe DiscountRule, type: :model do
  it "is valid with a watch_id, discounted_price and discount_quantity" do
    rule = FactoryBot.build(:discount_rule)

    expect(rule).to be_valid
  end
end
