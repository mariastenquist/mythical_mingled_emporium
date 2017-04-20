class Admin::OrdersController < Admin::BaseController
  def index
    filter = params[:filter]
    @all_orders = Order.all
    @orders = filter ? Order.where(status: filter).order(:id) : Order.all.order(:id)
  end

  def update
    order = Order.find(params[:id])
    order.update!(status: params[:status])
    redirect_to admin_orders_path
  end
end
