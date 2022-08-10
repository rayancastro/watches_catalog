require 'rails_helper'

RSpec.describe Watch, type: :model do
  it "is valid with a name, and unit_price_cents" do
    watch = Watch.new(
      name: "Breitling",
      unit_price_cents: 300000
    )
    expect(watch).to be_valid
  end

  it "is invalid without a name" do
    watch = Watch.new(
      name: nil,
    )
    watch.valid?
    expect(watch.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a non-unique name" do
    watch = Watch.create(
      name: "Rolex",
      unit_price_cents: 4200
    )

    watch_2 = Watch.new(
      name: "Rolex",
    )
    watch_2.valid?
    expect(watch_2.errors[:name]).to include("has already been taken")
  end

  it "is invalid without a unit_price_cents" do
    watch = Watch.new(
      unit_price_cents: nil,
    )
    watch.valid?
    expect(watch.errors[:unit_price_cents]).to include("can't be blank")
  end

  it "is invalid with unit_price_cents negative" do
    watch = Watch.new(
      unit_price_cents: -2,
    )
    watch.valid?
    expect(watch.errors[:unit_price_cents]).to include("must be greater than or equal to 0")
  end
end
