class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Account created!'
      session[:user_id] = User.last.id

      redirect_to dashboard_path
    else
      flash[:failure] = 'Account creation failed'

      redirect_to new_user_path
    end
  end

  def show
    if current_user
      @user = User.includes(:orders).find(current_user.id)
    else
      flash[:failure] = 'Oops! You must be logged in to do that.'

      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
