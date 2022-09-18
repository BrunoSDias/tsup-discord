class HomeController < ApplicationController
  def index
    @total_friendship_requests_received = FriendshipRequest.where(target_id: @current_user).count
  end
end
