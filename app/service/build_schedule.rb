class BuildSchedule
  attr_accessor :date, :rule

  def initialize(date, rule)
    @date = date
    @rule = rule
  end

  def build_schedule
    self.rule == "null" ? build_one_day_schedule(self.date) : build_reccuring_schedule(self.date, self.rule)
  end

  def build_reccuring_schedule(date, rule)
    schedule = IceCube::Schedule.new(date.to_date)
    schedule.add_recurrence_rule RecurringSelect.dirty_hash_to_rule(rule)
    schedule
  end

  def build_one_day_schedule(date)
    schedule = IceCube::Schedule.new(date.to_date)
    schedule.add_recurrence_rule IceCube::Rule.daily.count(1)
    schedule
  end
end