require "rails_helper"

RSpec.describe UserEventRemindMailer, type: :mailer do
  describe 'user remind event notifications' do
    let(:user) { create(:user, email: "vixtir90@gmail.com") }
    let(:mail) { UserEventRemindMailer.remind_events(user) }

    it 'subject' do
      expect(mail.subject).to eq I18n.t('user_event_remind_mailer.remind_events.subject')
    end

    it 'mail to' do
      expect(mail.to).to eq([user.email])
    end

    it 'mail from' do
      expect(mail.from).to eql(['mycalendar@gmail.com'])
    end
  end
end
