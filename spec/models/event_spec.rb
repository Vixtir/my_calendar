require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build_stubbed(:event) }

  it { be_valid }
  it { belong_to :user }

  it { validate_presence_of :title }
  it { validate_presence_of :date }

  it "invalid without title" do
    event = build_stubbed(:event, title: nil)
    expect(event).to_not be_valid
  end

  it "invalid without date" do
    event = build_stubbed(:event, date: nil)
    expect(event).to_not be_valid
  end

  it "set shedule after save" do
    event = build(:event)
    event.save
    expect(event.schedule).to_not eql nil
  end

  it "default remind = false" do
    event = build(:event)
    event.save
    expect(event.remind).to eq false
  end

  describe "events for mailer" do
    before do
      @user1 = create(:user)
      @user2 = create(:user)
    end

    it "#tomorrow_events_ids return nil" do
      expect(Event.tomorrow_events_ids).to eql []
    end

    context "user 1" do
      context "create default event for tomorrow" do
        it "#tomorrow_events_ids return nil" do
          create(:event, user: @user1, date: Date.today + 1.day)
          expect(Event.tomorrow_events_ids).to eql []
        end
      end

      context "create remind event for tomorrow" do
        before { @event = create(:event, user: @user1, date: Date.today + 1.day, remind: true) }
        it "#tomorrow_events_ids not to be empty" do
          expect(Event.tomorrow_events_ids).to_not eql []
        end

        it "return event id" do
          expect(Event.tomorrow_events_ids).to include(@event.id)
        end
      end
    end

    context "#tomorrow_events_users" do
      context "when user 1 have tomorrow remind event, user 2 havnt" do
        before do
          create(:event, user: @user1, date: Date.today + 1.day, remind: true)
          create(:event, user: @user2, date: Date.today + 1.day)
        end

        it "return array with user 1 id" do
          expect(Event.tomorrow_events_users).to include(@user1.id)
        end

        it "return array without user 2 id" do
          expect(Event.tomorrow_events_users).to_not include(@user2.id)
        end
      end

      context "when both user have tomorrow remind event" do
        before do
          create(:event, user: @user1, date: Date.today + 1.day, remind: true)
          create(:event, user: @user2, date: Date.today + 1.day, remind: true)
        end

        it "return array with user 1 id" do
          expect(Event.tomorrow_events_users).to include(@user1.id)
        end

        it "return array with user 2 id" do
          expect(Event.tomorrow_events_users).to include(@user2.id)
        end
      end
    end
  end
end
