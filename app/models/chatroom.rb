class Chatroom < ApplicationRecord
  has_many :user_chatrooms, dependent: :destroy

  def start(current_user_id:, other_user_ids:)
    user_ids = other_user_ids.map(&:to_i).uniq << current_user_id
    finded_chatroom = Chatroom.search_chatroom(user_ids).first

    if finded_chatroom.present?
      return [true, finded_chatroom]
    end

    if save
      UserChatroom.insert_all(user_ids.map{ |user_id| { chatroom_id: id, user_id: user_id, created_at: Time.zone.now, updated_at: Time.zone.now }})

      broadcast(user_ids)
      return [true, self]
    end

    return [false, nil]
  end

  def broadcast(user_ids)
    all_users = UserChatroom
    .includes(:user)
    .where(user_chatrooms: { chatroom_id: id })

    user_ids.each do |user_id|
      values = all_users.select{|v| v.user_id != user_id }

      Turbo::StreamsChannel.broadcast_append_to "user_#{user_id}_chatrooms", target: "chatrooms", partial: "shared/chatroom", locals: { key: id, values: values }
    end
  end

  private

  def self.search_chatroom(user_ids)
    Chatroom
      .joins(:user_chatrooms)
      .where(user_chatrooms: { user_id: user_ids })
      .where("(select sum(uc2.user_id) from user_chatrooms uc2 where uc2.chatroom_id = chatrooms.id) = ?", user_ids.sum )
  end
end
