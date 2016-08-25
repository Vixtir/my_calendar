class EventOccurance
  def initialize(event)
    @event = event
  end
  
  def build_occurrences(start_date, end_date)
    @event.schedule.occurrences_between(start_date.to_datetime  ,end_date.to_datetime).map { |date|
	    i = Event.new()
	    i.title = @event.title
	    i.date = date
	    i
  	}
  end      
end
