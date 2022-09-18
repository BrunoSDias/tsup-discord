class AddBlockedToFriendship < ActiveRecord::Migration[7.0]
  def change
    add_column :friendships, :blocked, :boolean, default: false
  end
end
