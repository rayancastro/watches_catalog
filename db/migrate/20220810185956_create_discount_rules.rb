class CreateDiscountRules < ActiveRecord::Migration[7.0]
  def change
    create_table :discount_rules do |t|
      t.references :watch, null: false, foreign_key: true
      t.integer :discount_quantity
      t.integer :discounted_price_cents

      t.timestamps
    end
  end
end
