class PendingRequestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pending_requests_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
