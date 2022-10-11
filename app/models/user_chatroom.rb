class UserChatroom < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  has_many :message_groups, dependent: :destroy
end
