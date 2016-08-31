class UserEventRemindMailer < ApplicationMailer
  default from: 'mycalendar@gmail.com'

  def remind_events(user)
    @user = user
    mail to: @user.email, subject: default_i18n_subject
  end
end
