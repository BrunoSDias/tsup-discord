class CreateUserChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :user_chatrooms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
