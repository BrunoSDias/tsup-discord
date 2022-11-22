class FriendshipRequest < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :target, class_name: "User", foreign_key: "target_id"

  validates_uniqueness_of :sender_id, scope: [:target_id]
  validates_uniqueness_of :target_id, scope: [:sender_id]

  after_create_commit -> (friendship_request) {
    broadcast_append_to [friendship_request.sender, "friendship_requests"],
    target: "friendship_requests_container",
    partial: "friendship_requests/sender_friendship_request",
    locals: { friendship_request: friendship_request }

    broadcast_append_to [friendship_request.target, "friendship_requests"],
    target: "friendship_requests_container",
    partial: "friendship_requests/target_friendship_request",
    locals: { friendship_request: friendship_request }
  }

  after_commit -> (friendship_request) { 
    ActionCable.server.broadcast("pending_requests_#{friendship_request.target_id}", { total: FriendshipRequest.where(target_id: friendship_request.target_id).count })
  }
end
