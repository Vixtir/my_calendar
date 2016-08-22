json.array! @events do |event|
  json.title event.title
  json.date event.date
  json.dow [1]
end