class AddBoxes < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.date :month_date
      t.string :name
    end

    create_table :boxes do |t|
      t.integer :forecast
      t.integer :actual
      t.integer :box_type_id
      t.belongs_to :period
    end

    create_table :box_items, id: false do |t|
      t.belongs_to :box, index: true
      t.belongs_to :item, index: true
    end
    add_index :box_items, [ :box_id, :item_id ], unique: true
  end
end
