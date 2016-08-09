class Dashboard::UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to(home_welcome_path, notice: t('logout.message'))
  end
end