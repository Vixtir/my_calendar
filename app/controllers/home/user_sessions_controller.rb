class Home::UserSessionsController < ApplicationController
	def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(dashboard_welcome_path, notice: t('login.success'))
    else
      flash.now[:alert] = t('login.fail')
      render action: 'new'
    end
  end
end