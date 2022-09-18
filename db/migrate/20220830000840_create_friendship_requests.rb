class CreateFriendshipRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friendship_requests do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :target, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index(:friendship_requests, [:sender_id, :target_id], unique: true)
    add_index(:friendship_requests, [:target_id, :sender_id], unique: true)
  end
end
