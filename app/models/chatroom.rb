class Chatroom < ApplicationRecord
  has_many :user_chatrooms, dependent: :destroy

  def self.start(user_ids)
    chatroom = Chatroom.new

    if already_exist_chatroom?(user_ids)
      chatroom.erros.add(:base, "Sala já existe")
      return chatroom
    end

    if chatroom.save
      UserChatroom.insert_all(user_ids.map{ |user_id| { chatroom_id: chatroom.id, user_id: user_id, created_at: Time.zone.now, updated_at: Time.zone.now }})
    end

    chatroom.broadcast(user_ids)
    chatroom
  end

  def broadcast(user_ids)
    users = User.where(id: user_ids)
   
    user_ids.each do |user_id|
      Turbo::StreamsChannel.broadcast_append_to "user_#{user_id}_chatrooms", target: "chatrooms", partial: "shared/chatroom", locals: { chatroom: self, users: users }
    end
  end

  private

  def self.already_exist_chatroom?(user_ids)
    Chatroom
      .joins(:user_chatrooms)
      .where(user_chatrooms: { user_id: user_ids })
      .where("(select sum(uc2.id) from user_chatrooms uc2 where uc2.chatroom_id = chatrooms.id) = ?", user_ids.map(&:to_i).uniq.sum)
      .exists?
  end
end
