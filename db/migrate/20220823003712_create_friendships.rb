class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user1, null: false, foreign_key: { to_table: :users }
      t.references :user2, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index(:friendships, [:user1_id, :user2_id], unique: true)
    add_index(:friendships, [:user2_id, :user1_id], unique: true)
  end
end
