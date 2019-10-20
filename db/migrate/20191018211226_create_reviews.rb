class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false
      t.belongs_to :store, null: false
      t.integer :rate, null: false
      t.date :date, null: false
      t.text :comment
      t.text :reply

      t.timestamps
    end
  end
end
