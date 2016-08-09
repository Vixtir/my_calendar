require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build_stubbed(:user) }

  it { be_valid }
  it { validate_uniqueness_of :email }
  it { validate_presence_of :email }
  it { validate_presence_of :password }
  it { validate_presence_of :password_confirmation }
  it { validate_confirmation_of :password }
end
