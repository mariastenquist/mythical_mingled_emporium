class Admin::UsersController < Admin::BaseController
  before_action :set_admin, only: [:show, :edit]

  def show; end

  def edit; end

  def update
    current_user.update(user_params)
    flash[:success] = 'Info Updated'
    redirect_to admin_dashboard_path
  end

  def index
    @users = User.all.order(:id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end

  def set_admin
    @admin = current_user
  end
end
