module SidebarHelper
  def sidebar_user_avatars(values)
    content_tag :div, class: "position-relative sidebar__user_avatars_container" do
      if values.size == 1
        [if values[0].user.avatar.attached?
          image_tag values[0].user.avatar, class: 'rounded-circle position-absolute', width: 40, height: 40, style: "left: 10px;"
        else
          tag.i class: "bi bi-person-fill position-absolute", style: 'font-size: 28px;'
        end,
        render("shared/friendship_status", user: values[0].user)
      ].join(" ").html_safe
      else
        content_tag :div, class: "rounded-circle position-relative bg-warning" do
          [
            tag.i(class: "bi bi-person-fill position-absolute", style: 'font-size: 28px; left: 5px;'),
            tag.i(class: "bi bi-person-fill position-absolute", style: 'font-size: 28px; left: 9px; color: #ffffffab')
          ].join(" ").html_safe
        end
      end
    end
  end

  def sidebar_user_names(values)
    tag.p class: "m-0 sidebar__user_names", style: "text-overflow: ellipsis; font-size: 16px;" do
      values.map{|value| value.user.name }.join(", ")
    end
  end

  def members_count(values)
    size = values.size
    return tag.span style: 'font-size: 13px;' do
      "#{size} Membros"
    end if size > 1
  end
end