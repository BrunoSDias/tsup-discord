class HomeController < ApplicationController
  def index
    @total_friendship_requests_received = FriendshipRequest.where(target_id: @current_user).load_async.count
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
