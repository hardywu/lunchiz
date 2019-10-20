class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.belongs_to :user, null: false, index: { unique: true }
      t.string :name, null: false

      t.timestamps
    end
  end
end
