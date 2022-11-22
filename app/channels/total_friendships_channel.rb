class TotalFriendshipsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "total_friendships_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
