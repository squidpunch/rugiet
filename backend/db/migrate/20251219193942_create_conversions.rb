class CreateConversions < ActiveRecord::Migration[8.1]
  def change
    create_table :conversions do |t|
      t.string :source, null: false, limit: 3
      t.string :target, null: false, limit: 3
      t.decimal :source_amount, null: false, precision: 15, scale: 2
      t.decimal :amount, null: false, precision: 15, scale: 2
      t.decimal :exchange_rate, null: false, precision: 10, scale: 6
      t.datetime :rate_fetched_time, null: false

      t.timestamps
    end
  end
end
