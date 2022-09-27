class Chatroom < ApplicationRecord
  has_many :user_chatrooms, dependent: :destroy

  def start(current_user_id:, other_user_ids:)
    user_ids = other_user_ids.map(&:to_i).uniq << current_user_id

    if already_exist_chatroom?(user_ids)
      self.errors.add(:base, "Sala já existe")
      return false
    end

    if save
      UserChatroom.insert_all(user_ids.map{ |user_id| { chatroom_id: id, user_id: user_id, created_at: Time.zone.now, updated_at: Time.zone.now }})

      broadcast(user_ids)
      return true
    end

    false
  end

  def broadcast(user_ids)
    users = User.where(id: user_ids)

    user_ids.each do |user_id|
      friend_users = users.where.not(id: user_id)

      Turbo::StreamsChannel.broadcast_append_to "user_#{user_id}_chatrooms", target: "chatrooms", partial: "shared/chatroom", locals: { chatroom: self, users: friend_users, current_user_id: user_id }
    end
  end

  private

  def already_exist_chatroom?(user_ids)
    Chatroom
      .joins(:user_chatrooms)
      .where(user_chatrooms: { user_id: user_ids })
      .where("(select sum(uc2.user_id) from user_chatrooms uc2 where uc2.chatroom_id = chatrooms.id) = ?", user_ids.sum )
      .exists?
  end
end
