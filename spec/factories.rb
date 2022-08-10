FactoryBot.define do
  factory(:watch) do
    name { Faker::Coffee.blend_name }
    unit_price_cents { rand(20000) }
  end
end
