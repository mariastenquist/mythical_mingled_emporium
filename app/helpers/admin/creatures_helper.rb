module Admin::CreaturesHelper
  def orders_count_link
    link_to "All: #{@all_orders.count}", admin_orders_path
  end

  def ordered_count_link
    link_to "Ordered: #{@all_orders.ordered.count}", admin_orders_path(filter: 'ordered')
  end

  def paid_count_link
    link_to "Paid: #{@all_orders.paid.count}", admin_orders_path(filter: 'paid')
  end

  def completed_count_link
    link_to "Completed: #{@all_orders.completed.count}", admin_orders_path(filter: 'completed')
  end

  def cancelled_count_link
    link_to "Cancelled: #{@all_orders.cancelled.count}", admin_orders_path(filter: 'cancelled')
  end

  def mark_as_paid_link
    return unless @order.ordered?

    link_to 'Mark as paid', admin_order_path(@order, status: 'paid'), method: :put
  end

  def cancel_link
    return unless @order.paid? || @order.ordered?

    link_to 'Cancel', order_path(@order), method: :put
  end

  def admin_cancel_link
    return unless @order.paid? || @order.ordered?

    link_to 'Cancel', admin_order_path(@order, status: 'cancelled'), method: :put
  end

  def mark_as_completed_link
    return unless @order.paid?

    link_to 'Mark as completed', admin_order_path(@order, status: 'completed'), method: :put
  end
end
