class Dashboard::EventsController < ApplicationController
	before_action :require_login
  before_action :set_user

	def new
		@event = @user.events.build
	end

  def index
    if params[:all].present?
      @events = Event.all
    else
      @events = @user.events
    end
    respond_to do |format|
       format.json
    end
  end

	def create
		@event = @user.events.create(event_params)
    @event.schedule = set_schedule
		if @event.save
			redirect_to root_path
			flash[:success] = t('event.create.success')
		else
			render :new
      flash.now[:alert] = t('event.create.error')
		end
	end

	def edit
		@event = @user.events.find_by(id: params[:id])
	end

	def update
		@event = @user.events.find_by(id: params[:id])
    @event.schedule = set_schedule
 		if @event.update_attributes(event_params)
			redirect_to root_path
			flash[:success] = t('event.update.success')
		else
			render :edit
      flash.now[:alert] = t('event.update.error')
		end
  end

  def set_schedule
    BuildSchedule.new(params[:event][:date], params[:event][:recurring_rule]).build_schedule
  end

	private

	def event_params
		params.require(:event).permit(:title, :date, :user_id, :recurring_rule)
	end

	def set_user
		@user = current_user
	end
end