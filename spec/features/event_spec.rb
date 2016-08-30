require 'rails_helper'

RSpec.describe "Event", type: "feature", js: true do
  let!(:user) { create(:user, email: "email@test.com") }
  let!(:user_2) do
    create(:user) do |user|
      user.events.create(attributes_for(:event, title: "User 2 Event"))
    end
  end

  before(:each) do
    login("email@test.com", "password")
  end

  context "see new header with" do
    it "link for new event" do
      expect(page).to have_content I18n.t('event.create.link')
    end

    it "link for new event" do
      expect(page).to have_link I18n.t('event.create.link')
    end

    it "link for event lists" do
      expect(page).to have_link I18n.t('all_events')
    end

    it "link for new event" do
      expect(page).to have_link "#{user.email}"
    end

    it "link for logout" do
      expect(page).to have_link I18n.t('logout.link')
    end
  end

  context "see new body with" do
    it "see calendar" do
      expect(page).to have_selector("#calendar")
    end
  end

  context "click link for new event" do
    before { click_link I18n.t('event.create.link') }

    it "render correct path" do
      expect(current_path).to eql new_dashboard_user_event_path(user)
    end

    context "fill valid params" do

      before do
        fill_in "Title", with: "User 1 Event"
        click_button "Create Event"
      end

      it "redirect to root_path" do
        expect(current_path).to eq root_path
      end

      it "redirect to root_path" do
        expect(page).to have_content I18n.t('event.create.success')
      end

      context "user default see just own events " do
        before do
          create(:event, title: "User 1 Event")
        end


        it "see event link" do
          expect(page).to have_link user.events.first.title
        end

        it "dont see user 2 event" do
          expect(page).to_not have_content user_2.events.first.title
        end
      end

      context "click all event link" do
        before do
          click_link I18n.t('all_events')
        end

        it "see own event" do
          expect(page).to have_content user.events.first.title
        end

        it "own event  have link" do
          expect(page).to have_link user.events.first.title
        end

        it "see user 2 event event" do
          expect(page).to have_content user_2.events.first.title
        end

        it "user 2 event have no link" do
          expect(page).to_not have_link user_2.events.first.title
        end
      end

      context "edit event" do
        before { click_link "User 1 Event" }

        it "redirect to edit path" do
          event = Event.find_by(title: "User 1 Event")
          expect(current_path).to eql edit_dashboard_user_event_path(user, event)
        end
      end
    end
  end
end