json.array! @events do |event|
	if event.schedule?
		json.title event.title
	  json.date event.schedule.all_occurrences
  end
end