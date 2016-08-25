@events.each do |event|
	json.array! EventOccurance.new(event).build_occurrences(params[:start], params[:end]) do |o|
    json.date o.date
    json.title o.title
    if event.user == current_user
    	json.color "#E4FF8A"
    	json.url edit_dashboard_user_event_path(current_user, event)
    else
      json.color "#FFB48A"
    end 
	end
end