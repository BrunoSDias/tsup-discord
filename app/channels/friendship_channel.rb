class FriendshipChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendship_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
