class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.string :base_currency, null: false
      t.monetize :amount, null: false
      t.date :date
      t.boolean :active, default: true
    end
  end
end
