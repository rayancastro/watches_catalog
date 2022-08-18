class RefactorNamesFromDiscountRules < ActiveRecord::Migration[7.0]
  def change
    rename_column :discount_rules, :discount_quantity, :bundle_size
    rename_column :discount_rules, :discounted_price_cents, :bundle_price_cents
  end
end
