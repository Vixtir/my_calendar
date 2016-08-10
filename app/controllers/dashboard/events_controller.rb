class Dashboard::EventsController < ApplicationController
	before_action :require_login

	def new
		@event = current_user.events.build
	end

	def create
		@event = current_user.events.create(event_params)

		if @event.save
			redirect_to dashboard_welcome_path
		else
			render "new"
		end
	end

	private

	def event_params
		params.require(:event).permit(:title, :date, :user_id)
	end
end