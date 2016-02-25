json.data(@data) do |point|
  json.value(point['value'])
  json.label(Time.parse(point['timeframe']['start']).strftime("%b %d"))
  json.date(point['timeframe']['start'])
end
