class Dashboard::EventsController < ApplicationController
	before_action :require_login

	def new
		@event = current_user.events.build
	end

	def create
		@event = current_user.events.create(event_params)
    pry
		if @event.save
			redirect_to dashboard_welcome_path
		else
			render "new"
		end
	end

	def edit
		@user = current_user
		@event = @user.events.find_by(id: params[:id])
	end

	def update
		@user = current_user
		@event = @user.events.find_by(id: params[:id])
		if @event.update_attributes(event_params)
			redirect_to dashboard_welcome_path
		else
			render :edit
		end
	end

	private

	def event_params
		params.require(:event).permit(:title, :date, :user_id)
	end
end