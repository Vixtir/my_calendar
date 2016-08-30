class Dashboard::UsersController < ApplicationController
  before_action :require_login
  before_action :set_user

  def show;  end

  def edit;  end

  def update
    if @user.update_attributes(user_params)
      redirect_to dashboard_welcome_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end