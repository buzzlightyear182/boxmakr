class AddBoxes < ActiveRecord::Migration[5.0]
  def change
    create_table :boxes do |t|
      t.integer :forecast
      t.integer :actual
      t.integer :box_type_id
      t.date :month_date
    end
    create_table :boxes_items, id: false do |t|
      t.belongs_to :box_id, index: true
      t.belongs_to :item_id, index: true
    end
  end
end
