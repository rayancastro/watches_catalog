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
  end

  it "is invalid without a unit_price_cents" do

  end
end
