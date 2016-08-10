class Dashboard::UsersController < ApplicationController
	before_action :require_login

	def index

	end

	def show

	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
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
end