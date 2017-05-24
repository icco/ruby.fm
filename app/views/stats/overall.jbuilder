json.data(@plays) do |play|
  json.value(play.total)
  json.label(play.bucket.strftime("%b %d"))
  json.date(play.bucket.iso8601)
end
