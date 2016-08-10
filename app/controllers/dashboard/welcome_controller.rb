class Dashboard::WelcomeController < ApplicationController
	before_action :require_login

	def index
		@events = current_user.events

		respond_to do |format|
			format.html
			format.json { render json: @events }
		end
	end
end