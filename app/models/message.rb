class Message < ApplicationRecord
  belongs_to :message_group

  validates :content, presence: true
end
