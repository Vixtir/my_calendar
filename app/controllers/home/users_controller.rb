class Home::UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		if @user.save
			auto_login(@user)
			redirect_to dashboard_welcome_path
			flash[:alert] = t("registrate.success")
		else
			flash[:alert] = t("registrate.fail")
			render 'new'
		end	
	end

	private

	def user_params
		params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
	end
end