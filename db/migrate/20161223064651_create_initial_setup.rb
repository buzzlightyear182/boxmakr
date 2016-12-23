class CreateInitialSetup < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, index: true, null: false, unique: true
      t.float :tariff_rate
    end

    create_table :companies do |t|
      t.string :name, index: true, null: false, unique: true
      t.text :address
      t.string :country
      t.string :email
      t.string :contact_person
      t.string :skype_id
    end

    create_table :brands do |t|
      t.string :name, index: true, null: false, unique: true
    end

    create_table :items do |t|
      t.string :name, index: true, null: false, unique: true
      t.boolean :top_SKU
      t.integer :shelf_life
      t.integer :weight
      t.integer :case_size
    end
  end
end
