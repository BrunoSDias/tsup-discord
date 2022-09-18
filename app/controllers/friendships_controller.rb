class FriendshipsController < ApplicationController
  def index
    @friendship_users = @current_user.friendship_users
  end

  def new
  end

  def header
    @total_friendship_requests_received = FriendshipRequest.where(target_id: @current_user.id).count
  end
end
