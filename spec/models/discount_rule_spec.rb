require 'rails_helper'

RSpec.describe DiscountRule, type: :model do
  it "is valid with a watch_id, discounted_price and discount_quantity" do
    rule = FactoryBot.build(:discount_rule)

    expect(rule).to be_valid
  end

  it "is invalid without a watch" do
    rule = FactoryBot.build(:discount_rule, watch: nil)

    rule.valid?
    expect(rule.errors[:watch]).to include("must exist")
  end

  it "is invalid without a discounted_price" do
    rule = FactoryBot.build(:discount_rule, discounted_price_cents: nil)

    rule.valid?
    expect(rule.errors[:discounted_price_cents]).to include("can't be blank")
  end

  it "is invalid with a negative discounted_price" do
    rule = FactoryBot.build(:discount_rule, discounted_price_cents: -2)

    rule.valid?
    expect(rule.errors[:discounted_price_cents]).to include("must be greater than or equal to 0")
  end

  it "is invalid without a discount_quantity" do
    rule = FactoryBot.build(:discount_rule, discount_quantity: nil)

    rule.valid?
    expect(rule.errors[:discount_quantity]).to include("can't be blank")
  end

  it "is invalid with a negative discount_quantity" do
    rule = FactoryBot.build(:discount_rule, discount_quantity: -2)

    rule.valid?
    expect(rule.errors[:discount_quantity]).to include("must be greater than or equal to 0")
  end
end
