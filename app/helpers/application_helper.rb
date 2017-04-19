module ApplicationHelper
  def print_welcome(user)
    message = 'Welcome!'
    message = "Welcome, #{user.username}!" if current_user
    content_tag(:h1, message)
  end

  def order_creature_subtotal(creature)
    quantity = @order.order_creatures.find_by(creature_id: creature.id).quantity
    subtotal = quantity * creature.price
    'Subtotal: ' + number_to_currency(subtotal)
  end
end
