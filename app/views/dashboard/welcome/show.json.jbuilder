json.array! @events do |event|
  json.title event.title
  json.date event.date
  json.url edit_dashboard_user_event_path(current_user, event)
end