class CreateBoxTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :box_types do |t|
      t.string :name, index: true, null: false, unique: true
      t.monetize :price
      t.monetize :target_cost
      t.monetize :threshold
      t.integer :max_item_count
    end

    create_table :exchange_rates do |t|
      t.string :base_currency, null: false
      t.monetize :amount, null: false
      t.date :date
      t.boolean :active, default: true
    end
  end
end
