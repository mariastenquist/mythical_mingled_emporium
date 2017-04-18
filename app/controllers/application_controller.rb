class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart

  def landing
    @user = current_user
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  private

  def set_cart
    @cart = Cart.new(session[:cart])
  end
end
