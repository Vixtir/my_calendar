class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

	def not_authenticated
  	redirect_to home_welcome_path, alert: t("not_authenticated")
	end
end
