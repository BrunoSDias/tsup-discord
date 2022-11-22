class UserChatroomsController < ApplicationController
  def destroy
    user_chatroom = UserChatroom.find_by(chatroom_id: params[:id], user_id: @current_user.id)
    if user_chatroom.destroy
      render json: {}, status: :ok
      return
    end

    render json: {}, status: :unathorized
  end
end
