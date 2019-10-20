class AddRateStatsToStores < ActiveRecord::Migration[6.0]
  def change
    change_table :stores do |t|
      t.integer :reviews_count, default: 0
      t.integer :rate_sum, default: 0
      t.decimal :rate_avg, default: 0
    end
  end
end
