require 'rails_helper'

RSpec.describe Watch, type: :model do
  it "is valid with a name, and unit_price_cents" do
    watch = FactoryBot.build(:watch)

    expect(watch).to be_valid
  end

  it "is invalid without a name" do
    watch = FactoryBot.build(:watch, name: nil)

    watch.valid?
    expect(watch.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a non-unique name" do
    watch = FactoryBot.create(:watch, name: "Rolex")
    watch_two = FactoryBot.build(:watch, name: "Rolex")

    watch_two.valid?
    expect(watch_two.errors[:name]).to include("has already been taken")
  end

  it "is invalid without a unit_price_cents" do
    watch = FactoryBot.build(:watch, unit_price_cents: nil)

    watch.valid?
    expect(watch.errors[:unit_price_cents]).to include("can't be blank")
  end

  it "is invalid with unit_price_cents negative" do
    watch = FactoryBot.build(:watch, unit_price_cents: -2)

    watch.valid?
    expect(watch.errors[:unit_price_cents]).to include("must be greater than or equal to 0")
  end
end
