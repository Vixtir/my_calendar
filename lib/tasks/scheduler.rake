desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  User.reminder_events
end