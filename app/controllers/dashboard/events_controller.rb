class Dashboard::EventsController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_event, only: [:edit, :update]

  def new
    @event = @user.events.build
  end

  def index
    @events = params[:all].present? ? Event.all : @user.events
    respond_to do |format|
       format.json
    end
  end

  def create
    @event = @user.events.create(event_params)
    if @event.save
      redirect_to root_path
      flash[:success] = t('event.create.success')
    else
      render :new
      flash.now[:alert] = t('event.create.error')
    end
  end

  def edit;  end

  def update
     if @event.update_attributes(event_params)
      redirect_to root_path
      flash[:success] = t('event.update.success')
    else
      render :edit
      flash.now[:alert] = t('event.update.error')
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :user_id, :recurring_rule)
  end

  def set_user
    @user = current_user
  end

  def set_event
    @event = @user.events.find_by(id: params[:id])
  end
end