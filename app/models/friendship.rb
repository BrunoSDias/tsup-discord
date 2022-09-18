class Friendship < ApplicationRecord
  belongs_to :user1, class_name: "User", foreign_key: "user1_id"
  belongs_to :user2, class_name: "User", foreign_key: "user2_id"

  enum status: { 
    available: 'disponivel',
    offline: 'offline',
    busy: 'não perturbar',
    unavailable: 'ausente'
  }

  validates_uniqueness_of :user1_id, scope: [:user2_id]
  validates_uniqueness_of :user2_id, scope: [:user1_id]
end
