require 'open-uri'
require 'nokogiri'

url = "http://www.opera-bordeaux.com/calendar"
html_file = open(url)
html_doc = Nokogiri::HTML(html_file)

all_events = {}

html_doc.search('.calendar-items').each do |calendar_items|
  attributes = {}
  # date-day
  attributes[:day] = calendar_items.search('.show-date-day').text
  # date-month
  attributes[:month] = calendar_items.search('.show-date-month').text
  # date-year
  attributes[:year] = calendar_items.search('.show-date-year').text

  calendar_items.search('.row').each_with_index do |row, index|
    # date-time
    if row.search('.show-place-time').text == ""
      attributes[:time] = calendar_items.search('.show-place-time').text
    else
      attributes[:time] = row.search('.show-place-time').text
    end
    # location
    if row.search('.tag-inverse').text == ""
      location = calendar_items.search('.tag-inverse').text
    else
      location = row.search('.tag-inverse').text
    end
    location = location.gsub(attributes[:time], "") # get rid of time
    location = location.strip
    attributes[:location] = location
    # event title
    title = row.search('.col-md-8').text
    title = title.tr('+', '').strip
    attributes[:title] = title
    # #
    all_events["#{attributes[:day]}-#{index}"] = attributes
  end
end

all_events.each_with_index do |key, index|
  puts '-' * 40
  puts "#{index} - #{key}"
end
