module SidebarHelper
  def sidebar_user_names_and_avatars(values)
    names = []
    avatars = []

    values.each do |value|
      names << value.user.name
      avatars << value.user.avatar
    end

    [names, avatars]
  end

  def sidebar_user_avatars(avatars)
    content_tag :div, class: "position-relative sidebar__user_avatars_container" do
      if avatars.size == 1
        if avatars[0].attached?
          image_tag avatars[0], class: 'rounded-circle position-absolute', width: 40, height: 40, style: "left: #{index * 10}px;"
        else
          tag.i class: "bi bi-person-fill position-absolute", style: 'font-size: 28px;'
        end
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

  def sidebar_user_names(names)
    tag.p class: "m-0 sidebar__user_names", style: "text-overflow: ellipsis; font-size: 16px;" do
      names.map{|name| name }.join(", ")
    end
  end

  def members_count(values)
    size = values.size
    return tag.span style: 'font-size: 13px;' do
      "#{size} Membros"
    end if size > 1
  end
end