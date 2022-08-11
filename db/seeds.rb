DiscountRule.destroy_all
Watch.destroy_all

puts "Creating watch catalogue"

watches_params = [
  { name: "Rolex", unit_price_cents: 10000 },
  { name: "Michael Kors", unit_price_cents: 8000 },
  { name: "Swatch", unit_price_cents: 5000 },
  { name: "Casio", unit_price_cents: 3000 }
]

Watch.create(watches_params)

puts "You have #{Watch.count} watches."

puts "Creating discount rules"

rolex = Watch.find_by(name: "Rolex")
michael_kors = Watch.find_by(name: "Michael Kors")

discount_rules_params = [
  { watch: rolex, bundle_size: 3, bundle_price_cents: 20000 },
  { watch: michael_kors, bundle_size: 2, bundle_price_cents: 12000 }
]

DiscountRule.create(discount_rules_params)
puts "You have #{DiscountRule.count} discount rules."
