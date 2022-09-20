class FriendshipsController < ApplicationController
  def index
    @friendship_users = @current_user.friendship_users
  end

  def new
  end

  def header
    @total_friendship_requests_received = FriendshipRequest.where(target_id: @current_user.id).count
  end

  def destroy
    @friend_user_id = params[:user_id]

    friendship = Friendship.where(user1_id: @current_user.id, user2_id: @friend_user_id).or(Friendship.where(user1_id: @friend_user_id, user2_id: @current_user.id)).first

    friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendship_users_url, notice: "Amizade removida com sucesso" }
      format.turbo_stream { flash.now[:notice] = "Amizade removida com sucesso" }
    end
  end
end
