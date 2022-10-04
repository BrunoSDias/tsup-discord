module MessagesHelper
  def user_avatar(user)
    return image_tag user.avatar, class: 'rounded-circle', width: 40, height: 40 if user.avatar.attached?
    tag.i class: "bi bi-person-check", style: 'font-size: 28px;'
  end
end
