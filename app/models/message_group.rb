class MessageGroup < ApplicationRecord
  belongs_to :user_chatroom

  has_many :messages
end
