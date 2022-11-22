class FriendshipsController < ApplicationController
  before_action :total_pending_friendships_request, only: [:header]
  before_action :friendship_users, only: [:index]

  def index
  end

  def new
  end

  def header
    friendship_users("and users.status = 'available'")
  end

  def destroy
    @friend_user_id = params[:user_id]

    friendship = Friendship.where(user1_id: @current_user.id, user2_id: @friend_user_id).or(Friendship.where(user1_id: @friend_user_id, user2_id: @current_user.id)).first
    friendship.destroy

    @friendship_users = @current_user.friendship_users
    @available_friendship_users = @current_user.friendship_users(extra_conditions: "and users.status = 'available'")

    respond_to do |format|
      format.html { redirect_to friendship_users_url, notice: "Amizade removida com sucesso" }
      format.turbo_stream { flash.now[:notice] = "Amizade removida com sucesso" }
    end
  end
end
