class CreateExchangeRates < ActiveRecord::Migration[8.1]
  def change
    create_table :exchange_rates do |t|
      t.string :base, null: false, limit: 3
      t.string :target, null: false, limit: 3
      t.date :date, null: false
      t.decimal :rate, null: false, precision: 10, scale: 6

      t.timestamps
    end

    add_index :exchange_rates, [:base, :target, :date]
  end
end
