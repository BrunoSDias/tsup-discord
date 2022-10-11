class CreateMessageGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :message_groups do |t|
      t.references :user_chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
