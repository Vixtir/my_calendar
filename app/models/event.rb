class Event < ActiveRecord::Base
  include IceCube
  
  attr_accessor :color

  serialize :schedule, IceCube::Schedule

  before_save :set_schedule

	belongs_to :user

	validates :title,
						:date,
						presence: true

  def set_schedule
    self.schedule = BuildSchedule.new(self.date, self.recurring_rule).build_schedule
  end

  def current_rule
    self.schedule.to_hash[:rrules]
  end
end
