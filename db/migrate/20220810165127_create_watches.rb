class CreateWatches < ActiveRecord::Migration[7.0]
  def change
    create_table :watches do |t|
      t.string :name
      t.integer :unit_price_cents

      t.timestamps
    end
  end
end
