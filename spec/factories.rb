FactoryBot.define do
  factory :discount_rule do
    association :watch
    discount_quantity { 1 }
    discounted_price_cents { 1 }
  end

  factory(:watch) do
    name { Faker::Coffee.blend_name }
    unit_price_cents { rand(20000) }
  end
end
