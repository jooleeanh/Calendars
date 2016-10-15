require 'open-uri'
require 'nokogiri'
require 'date'

url = "http://www.opera-bordeaux.com/calendar?keys=&field_date_show_date_value=&term_node_tid_depth=All&term_node_tid_depth_1=All&field_public_type_target_id=All&field_accessibilite_value=All"
html_file = open(url)
html_doc = Nokogiri::HTML(html_file)

all_events = {}

MONTH = %w(index0 janvier février mars avril mai juin juillet août septembre octobre novembre décembre)

html_doc.search('.calendar-result').search('.row').each_with_index do |row, index|
  attributes = {}
  # date-day
  attributes[:day] = row.search('.show-date-day').text.to_i
  # date-month
  month = row.search('.show-date-month').text
  month = MONTH.index(month)
  attributes[:month] = month
  # date-year
  attributes[:year] = row.search('.show-date-year').text.to_i

  row.each do |_|
    # attributes = common_attributes
    # date-time
    time = row.search('.show-place-time').text
    attributes[:time] = time
    array = time.split(" ")
    hour = array[0].to_i
    # hour -= 12 if hour > 12
    attributes[:hour] = hour
    minutes = array[2].to_i
    attributes[:minutes] = minutes
    # date = Time.new(attributes[:year], attributes[:month], attributes[:day], attributes[:hour], attributes[:minutes], 0, "+02:00")
    date = Time.new(attributes[:year], attributes[:month], attributes[:day], attributes[:hour], attributes[:minutes], 0, "+02:00") unless attributes[:day] == 0
    # date = Time.new(1993, 02, 24, 12, 0, 0, "+09:00")
    attributes[:date] = date
    # artists
    artists = row.search('.show-author').text
    attributes[:artists] = artists
    # details
    details = row.search('.show-more').text
    details = details.strip
    attributes[:details] = details
    # info
    info = row.search('.date-show-info').text
    info = info.strip.gsub(/\s#.{7}/, "")
    attributes[:info] = info
    # location
    if row.search('.tag-inverse').text == ""
      location = row.search('.tag-inverse').text
    else
      location = row.search('.tag-inverse').text
    end
    location = location.gsub(attributes[:time], "") # get rid of time
    location = location.gsub(/\\.|\s{2,}/, "") # get rid of \n and \s
    # location = location.strip
    attributes[:location] = location
    # event title
    title = row.search('.col-md-8').text
    title = title.gsub(attributes[:artists], "")
    title = title.gsub(attributes[:details], "")
    title = title.gsub(attributes[:info], "")
    title = title.gsub(/\s#.{7}/, "")
    title = title.tr('+', '').strip
    attributes[:title] = title
    # store in hash
    if attributes[:day] == 0
      # do nothing
    else
      all_events["#{attributes[:day]}-#{index}"] = attributes
    end
  end

end

# url
array = []
html_doc.search('//a[@href][@hreflang]').each do |link|
  array << link['href']
end

all_events.each_with_index do |key, index|
  puts '-' * 40
  puts "#{index} - #{key}"
end
