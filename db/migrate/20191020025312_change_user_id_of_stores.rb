class ChangeUserIdOfStores < ActiveRecord::Migration[6.0]
  def up
    change_table :stores do |t|
      t.remove_index :user_id
      t.change :user_id, :bigint, null: true
      t.rename :user_id, :owner_id
      t.index :owner_id, unique: false
    end
  end

  def down
    change_table :stores do |t|
      t.remove_index :owner_id
      t.change :owner_id, :bigint, null: false
      t.rename :owner_id, :user_id
      t.index :user_id, unique: true
    end
  end
end
