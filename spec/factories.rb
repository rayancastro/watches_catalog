FactoryBot.define do
  factory :discount_rule do
    association :watch
    bundle_size { 1 }
    bundle_price_cents { 1 }
  end

  factory(:watch) do
    name { Faker::Coffee.blend_name }
    unit_price_cents { rand(20000) }
  end
end
