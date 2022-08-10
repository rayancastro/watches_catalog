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
p Watch.all
