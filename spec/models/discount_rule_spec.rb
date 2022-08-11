require 'rails_helper'

RSpec.describe DiscountRule, type: :model do
  it "is valid with a watch_id, discounted_price and bundle_size" do
    rule = FactoryBot.build(:discount_rule)

    expect(rule).to be_valid
  end

  it "is invalid without a watch" do
    rule = FactoryBot.build(:discount_rule, watch: nil)

    rule.valid?
    expect(rule.errors[:watch]).to include("must exist")
  end

  it "is invalid without a discounted_price" do
    rule = FactoryBot.build(:discount_rule, bundle_price_cents: nil)

    rule.valid?
    expect(rule.errors[:bundle_price_cents]).to include("can't be blank")
  end

  it "is invalid with a negative discounted_price" do
    rule = FactoryBot.build(:discount_rule, bundle_price_cents: -2)

    rule.valid?
    expect(rule.errors[:bundle_price_cents]).to include("must be greater than or equal to 0")
  end

  it "is invalid without a bundle_size" do
    rule = FactoryBot.build(:discount_rule, bundle_size: nil)

    rule.valid?
    expect(rule.errors[:bundle_size]).to include("can't be blank")
  end

  it "is invalid with a negative bundle_size" do
    rule = FactoryBot.build(:discount_rule, bundle_size: -2)

    rule.valid?
    expect(rule.errors[:bundle_size]).to include("must be greater than or equal to 0")
  end
end
