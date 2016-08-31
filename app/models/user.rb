class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :events, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: [:create, :edit]


  def self.reminder_events
    users = Event.tomorrow_events_users
    User.where(id: users).each do |user|
      UserEventRemindMailer.remind_events(user).deliver_now
    end
  end
end
