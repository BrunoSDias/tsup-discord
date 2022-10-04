module SidebarHelper
  def stack_users_avatar(values)
    content_tag :div, class: "position-relative sidebar__user_avatars_container" do
      values.map.with_index do |value, index|
        if value.user.avatar.attached?
          image_tag value.user.avatar, class: 'rounded-circle position-absolute', width: 40, height: 40, style: "left: #{index * 10}px;"
        else
          tag.i class: "bi bi-person-check position-absolute", style: 'font-size: 28px;'
        end
      end.join("").html_safe
    end
  end

  def stack_users_name(values)
    tag.p class: "m-0 sidebar__user_names", style: "text-overflow: ellipsis;" do
      values.map{|value| value.user.name }.join(", ")
    end
  end

  def members_count(values)
    size = values.size
    return tag.span style: 'font-size: 15px' do
      "#{size} Membros"
    end if size > 1
  end
end