require_relative 'TNBA_parser'
require 'pry-byebug'
require 'open-uri'
require 'nokogiri'

events_url = "http://www.tnba.org/page/saison-2016-2017"
# events_html = "season_2016_2017.html"
# event_html = "tnba_event.html"
events_doc = Nokogiri::HTML(open(events_url), nil, 'utf-8')
tnba = TnbaParser.new(events_doc)
tnba.parse_events
links = tnba.links
links.delete("/evenements/saison-2016-2017")
all_events_hash = {}

links.each_with_index do |link, index|
  current_event = TnbaParser.new(events_doc)
  url = "http://www.tnba.org" + link
  current_event.event = Nokogiri::HTML(open(url), nil, 'utf-8')
  current_event.parse_event
  all_events_hash[index] = current_event.attributes
end

def store_json(all_events_hash)
  filepath = Time.now.strftime('files/TNBA_%Y-%m-%d')
  File.open("#{filepath}.json", 'w') do |file|
    file.write(JSON.generate(all_events_hash))
  end
end

store_json(all_events_hash)

puts "Done"
