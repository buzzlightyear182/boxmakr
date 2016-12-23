class CreateBoxTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :box_types do |t|
      t.string :name, index: true, null: false, unique: true
      t.monetize :base_price
      t.monetize :threshold
      t.integer :max_item_count
    end
  end
end
