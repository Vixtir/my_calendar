require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build_stubbed(:event) }

  it { be_valid }
  it { belong_to :user }

  it { validate_presence_of :title }
  it { validate_presence_of :date }
 
end
