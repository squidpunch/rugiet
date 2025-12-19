class AddUniqueIndexToExchangeRates < ActiveRecord::Migration[8.1]
  def change
    # Remove the existing non-unique index
    remove_index :exchange_rates, [:base, :target, :date]

    # Add a unique index on the combination of base, target, and date
    add_index :exchange_rates, [:base, :target, :date], unique: true
  end
end
