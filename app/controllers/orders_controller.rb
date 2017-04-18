class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders
    else
      flash[:failure] = 'Oops! You must be logged in to do that.'

      redirect_to login_path
    end
  end

  def show
    order = Order.find(params[:id])
    unless order.user_id == current_user.id || current_admin?
      flash[:failure] = 'Order doesnt exist'

      redirect_to orders_path
    else
      @order = order
    end
  end

  def create
    user = User.find(session[:user_id].to_i)

    order = user.orders.create(total: @cart.total_price.to_s)

    @cart.contents.each do |id, quantity|
      order.order_creatures.create(creature: Creature.find(id),
                                   quantity: quantity)
    end

    flash[:success] = 'Order was successfully placed'

    redirect_to orders_path
  end

  def update
    order = Order.find(params[:id])
    order.cancelled!
    redirect_to dashboard_path
  end
end
