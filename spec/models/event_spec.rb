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
end
