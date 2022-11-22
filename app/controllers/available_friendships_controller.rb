class AvailableFriendshipsController < ApplicationController

  def index
    friendship_users("and users.status = 'available'")
  end
end
