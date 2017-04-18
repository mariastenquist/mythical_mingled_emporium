module ApplicationHelper
  def print_welcome(user)
    message = 'Welcome!'
    message = "Welcome, #{user.username}!" if current_user
    content_tag(:h1, message)
  end
end
