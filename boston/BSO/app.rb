require_relative 'bso_calendar_parser'
require_relative 'bso_event_parser'

bso = BsoCalendarParser.new
bso.parse_links
links = bso.calendar_links
events = {}

link = links.first
links.each_with_index do |link, index|
  event = BsoEventParser.new(link)
  event.parse_all
  events[index] = event.attributes
end

puts "Done"

def store_json(events)
  filepath = Time.now.strftime('files/BSO_%Y-%m-%d-%H-%M')
  File.open(filepath + '.json', 'w') do |file|
    file.write(JSON.generate(events))
  end
end

store_json(events)
