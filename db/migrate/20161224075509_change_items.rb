class ChangeItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :name, :string
    remove_column :items, :weight, :integer
    add_column :items, :description, :string, index: true, unique: true
    add_column :items, :category_id, :integer
    add_column :items, :case_weight, :float
    add_column :items, :brand_id, :integer, index: true
    add_monetize :items, :case_price, currency: { present: false }
    add_column :items, :case_price_currency, :string
    add_column :items, :case_pallet, :integer
    add_column :items, :unit_size, :string
    add_column :items, :case_dimension_length, :float
    add_column :items, :case_dimension_width, :float
    add_column :items, :case_dimension_height, :float
  end
end
