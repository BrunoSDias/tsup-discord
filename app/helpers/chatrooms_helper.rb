module ChatroomsHelper
  def chatroom_header(users)
    content_tag :div, class: 'd-flex w-100 align-items-center' do
      image_header = chatroom_header_images(users: users)
      names_header = chatroom_header_names(users: users)

      [image_header, names_header].join(" ").html_safe
    end
  end

  def chatroom_main(users)
    content_tag :div, class: 'w-100' do
      image_main = chatroom_header_images(users: users, background: 'rgb(255, 193, 7) !important', font_size: '40px;', container_width: '80px;', container_height: '75px;', margin_left: '-35px')
      names_main = chatroom_header_names(users: users, style: "text-overflow: ellipsis;font-size: 28px;font-weight: bold;margin-top: 10px !important;")
      welcome_message = chatroom_welcome_message(users: users, font_size: '15px;')

      [image_main, names_main, welcome_message].join(" ").html_safe
    end
  end

  def chatroom_header_images(users:, background: 'transparent', font_size: '21px;', container_width: '36px', container_height: '30px', margin_left: '-25px')
    if users.size == 1
      tag.i class: "bi bi-at", style: "font-size: #{font_size};"
    else
      content_tag :div, class: "rounded-circle position-relative d-flex align-items-center justify-content-center", style: "width: #{container_width}; height: #{container_height}; background-color: #{background}" do
        [
          tag.i(class: "bi bi-person-fill", style: "font-size: #{font_size}; color: #ffffff;"),
          tag.i(class: "bi bi-person-fill", style: "font-size: #{font_size}; margin-left: #{margin_left}; color: #ffffffab")
        ].join(" ").html_safe
      end
    end
  end


  def chatroom_header_names(users:, style: 'text-overflow: ellipsis; font-size: 16px;')
    tag.p class: "m-0", style: style do
      users.map{|user| user.name }.join(", ")
    end
  end

  def chatroom_welcome_message(users:, font_size: '12px')
    content_tag :p do
      [
        tag.span(class: 'text-muted', style: "font-size: #{font_size}") { "Bem-vindo(ou vinda) ao começo do grupo" },
        tag.span(style: 'font-weight: bold; font-size: #{font_size}; color: #ffffff;') { users.map(&:name).join(", ") }
      ].join(" ").html_safe
    end
  end
end
