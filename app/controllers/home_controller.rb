class HomeController < ApplicationController
  before_action :total_pending_friendships_request, only: [:index]

  def index
    friendship_users("and users.status = 'available'")

    @users = @current_user.friendship_users
    @chatrooms = @current_user.chatrooms
    @chatroom_groups = UserChatroom
                        .includes(:user)
                        .where(user_chatrooms: { chatroom_id: @chatrooms.map(&:id) })
                        .where.not(user_chatrooms: { user_id: @current_user.id })
                        .load_async
                        .group_by { |user_chatroom| user_chatroom.chatroom_id }
  end
end
