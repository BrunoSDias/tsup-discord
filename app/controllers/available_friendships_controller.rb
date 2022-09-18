class AvailableFriendshipsController < ApplicationController
  def index
    @friendship_users = @current_user.friendship_users(extra_conditions: "and users.status = 'available'")
  end
end
