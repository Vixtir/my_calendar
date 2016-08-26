class Dashboard::WelcomeController < ApplicationController
	before_action :require_login

	def show
		if params[:all].present?
			@events = Event.all
		else
			@events = current_user.events
		end
		respond_to do |format|
			format.html
			format.json
		end
	end

	def index
		@events = Event.all
		respond_to do |format|
			format.html
			format.json
		end
	end
end