json.data(@plays) do |play|
  json.value(play.total)
  json.label(play.date.strftime("%b %d"))
  json.date(play.date.iso8601)
end
