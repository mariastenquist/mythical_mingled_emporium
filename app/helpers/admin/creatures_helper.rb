module Admin::CreaturesHelper
  def orders_count_link
    link_to "All: #{@all_orders.count}", admin_orders_path, class: 'btn'
  end

  def ordered_count_link
    path = admin_orders_path(filter: 'ordered')
    link_to "Ordered: #{@all_orders.ordered.count}", path, class: 'btn'
  end

  def paid_count_link
    path = admin_orders_path(filter: 'paid')
    link_to "Paid: #{@all_orders.paid.count}", path, class: 'btn'
  end

  def completed_count_link
    path = admin_orders_path(filter: 'completed')
    link_to "Completed: #{@all_orders.completed.count}", path, class: 'btn'
  end

  def cancelled_count_link
    path = admin_orders_path(filter: 'cancelled')
    link_to "Cancelled: #{@all_orders.cancelled.count}", path, class: 'btn'
  end

  def mark_as_paid_link
    return unless @order.ordered?

    path = admin_order_path(@order, status: 'paid')
    link_to 'Mark as paid', path, method: :put, class: 'btn'
  end

  def cancel_link
    return unless @order.paid? || @order.ordered?

    link_to 'Cancel', order_path(@order), method: :put, class: 'btn'
  end

  def admin_cancel_link
    return unless @order.paid? || @order.ordered?

    path = admin_order_path(@order, status: 'cancelled')
    link_to 'Cancel', path, method: :put, class: 'btn'
  end

  def mark_as_completed_link
    return unless @order.paid?

    path = admin_order_path(@order, status: 'completed')
    link_to 'Mark as completed', path, method: :put, class: 'btn'
  end
end
