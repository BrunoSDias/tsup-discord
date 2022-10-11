class AlterReferenceFromUserChatroomToMessageGroupOnMessages < ActiveRecord::Migration[7.0]
  def up
    remove_reference :messages, :user_chatroom
    add_reference :messages, :message_group, index: true
  end

  def down
    add_reference :messages, :user_chatroom, index: true
    remove_reference :messages, :message_group
  end
end
