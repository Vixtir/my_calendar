class BuildSchedule
  def initialize(date, rule)
  	@date = date
  	@recurring_rule = rule
  end

  def build_schedule(params)
  	params[:event][:recurring_rule] == "null" ? build_one_day_schedule(params) : build_schedule(params)
  end

  def build_schedule(params)
    schedule = IceCube::Schedule.new(params[:event][:date])
    schedule.add_recurrence_rule RecurringSelect.dirty_hash_to_rule(params[:event][:recurring_rule])	
    schedule
	end

	def build_one_day_schedule(params)
		schedule = IceCube::Schedule.new(params[:event][:date])
		schedule.add_recurrence_rule IceCube::Rule.daily.count(1)
		schedule
	end
end