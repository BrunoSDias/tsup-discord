class Blocked < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :target, class_name: "User", foreign_key: "target_id"
  
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
