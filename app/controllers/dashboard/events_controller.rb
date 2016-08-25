class Dashboard::EventsController < ApplicationController
	before_action :require_login

	def new
		@event = current_user.events.build
	end

	def create
		@event = current_user.events.create(event_params)
    schedule = params[:event][:recurring_rule] == "null" ? build_one_day_schedule(params) : build_schedule(params)
    @event.schedule = schedule
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
		schedule = params[:event][:recurring_rule] == "null" ? build_one_day_schedule(params) : build_schedule(params)
    @event.schedule = schedule
 		if @event.update_attributes(event_params)
			redirect_to dashboard_welcome_path
		else
			render :edit
		end
	end

	def build_schedule(params)
    schedule = IceCube::Schedule.new(params[:event][:date].to_date)
    schedule.add_recurrence_rule RecurringSelect.dirty_hash_to_rule(params[:event][:recurring_rule])	
    schedule
	end

	def build_one_day_schedule(params)
		schedule = IceCube::Schedule.new(params[:event][:date].to_date)
		schedule.add_recurrence_rule IceCube::Rule.daily.count(1)
		schedule
	end

	private

	def event_params
		params.require(:event).permit(:title, :date, :user_id, :recurring_rule)
	end
end