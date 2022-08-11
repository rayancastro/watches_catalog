class RefactorNamesFromDiscountRules < ActiveRecord::Migration[7.0]
  def change
    rename_column :discount_rules, :bundle_size, :bundle_size
    rename_column :discount_rules, :bundle_price_cents, :bundle_price_cents
  end
end
