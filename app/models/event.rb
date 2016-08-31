class Event < ActiveRecord::Base
  include IceCube
  
  attr_accessor :color

  serialize :schedule, IceCube::Schedule

  before_save :set_schedule

  belongs_to :user

  validates :title,
            :date,
            presence: true

  scope :need_remind, -> { where('remind = ?', true) }
  scope :tomorrow, -> { where(id: Event.tomorrow_events_ids) }

  def set_schedule
    self.schedule = BuildSchedule.new(self.date, self.recurring_rule).build_schedule
  end

  def current_rule
    self.schedule.to_hash[:rrules]
  end

  def self.tomorrow_events_ids
    result = []
    self.need_remind.each do |event|
      result << event.id if event.schedule.occurs_on?(Date.today + 1)
    end
    result
  end

  def self.tomorrow_events_users
    result = []
    self.need_remind.tomorrow.each do |event|
      result << event.user_id
    end
    result.uniq
  end
end
