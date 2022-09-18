class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  has_many :blockeds, class_name: "Blocked", foreign_key: "sender_id"

  enum status: {
    'disponivel': 'available',
    'ausente': 'unavailable',
    'nao perturbar': 'occupied',
    'ausente': 'offiline'
  }
  
  def friendship_users(extra_conditions: '')
    self.class.find_by_sql("
      Select users.* from users 
      inner join friendships on friendships.user1_id = users.id
      where friendships.user2_id = #{id} and
      (
        select count(blockeds.id) from blockeds where
        (blockeds.sender_id = #{id} and blockeds.target_id = users.id) OR
        (blockeds.sender_id = users.id and blockeds.target_id = #{id})
      ) = 0
      #{extra_conditions}
      UNION
      Select users.* from users inner join friendships on friendships.user2_id = users.id
      where friendships.user1_id = #{id} and
      (
        select count(blockeds.id) from blockeds where
        (blockeds.sender_id = #{id} and blockeds.target_id = users.id) OR
        (blockeds.sender_id = users.id and blockeds.target_id = #{id})
      ) = 0
      #{extra_conditions}
    ")
  end
  
  def friendship_requests
    self.class.find_by_sql("
      Select users.* from users 
      inner join friendship_requests on friendship_requests.sender_id = users.id
      where friendship_requests.target_id = #{id}
      UNION
      Select users.* from users inner join friendship_requests on friendship_requests.target_id = users.id
      where friendship_requests.sender_id = #{id}
    ")
  end
end
