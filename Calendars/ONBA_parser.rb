require 'open-uri'
require 'nokogiri'
require 'csv'
require 'json'
require 'colorize'
require 'pry-byebug'

def make_html_doc
  url = "http://www.opera-bordeaux.com/calendar?keys=&field_date_show_date_value=&term_node_tid_depth=All&term_node_tid_depth_1=All&field_public_type_target_id=All&field_accessibilite_value=All"
  html_file = open(url)
  Nokogiri::HTML(html_file)
end

MONTH = %w(index0 janvier février mars avril mai juin juillet août septembre octobre novembre décembre)



def get_date(row)
  # date-day
  day = row.search('.show-date-day').text.to_i
  # date-month
  month = row.search('.show-date-month').text
  month = MONTH.index(month)
  # date-year
  year = row.search('.show-date-year').text.to_i
  [year, month, day]
end

def get_time(row)
  time = row.search('.show-place-time').text
  # attributes[:time] = time
  array = time.split(" ")
  hour = array[0].to_i
  minutes = array[2].to_i
  [hour, minutes]
end

def make_date(date, time)
  Time.new(date[0], date[1], date[2], time[0], time[1], 0, "+02:00") unless date[2] == 0
end

def get_metadata(row)
  time = row.search('.show-place-time').text
  hash = {}
  hash[:artists] = row.search('.show-author').text
  hash[:details] = row.search('.show-more').text.strip
  hash[:info] = row.search('.date-show-info').text.strip.gsub(/\s#.{7}/, "")
  hash[:location] = row.search('.tag-inverse').text.gsub(time, "").gsub(/\\.|\s{2,}/, "")
  hash
end

def get_title(row, attributes)
  title = row.search('.col-md-8').text
  title = title.gsub(attributes[:artists], "").gsub(attributes[:details], "")
  title = title.gsub(attributes[:info], "").gsub(/\s#.{7}/, "")
  title.tr('+', '').strip
end

def onba_scraper(html_doc)
  event_hash = {}
  html_doc.search('.calendar-result').search('.row').each_with_index do |row, index|
    attributes = {}
    date = get_date(row)
    row.each do |_|
      attributes[:date] = make_date(date, get_time(row))
      attributes = attributes.merge(get_metadata(row))
      attributes[:title] = get_title(row, attributes)
      invalid_entry = attributes[:date] == nil
      event_hash["#{attributes[:date].day}-#{index}"] = attributes unless invalid_entry
    end
  end
  event_hash
end

def print_hash(event_hash)
  event_hash.each_with_index do |key, index|
    puts '-' * 40
    puts "#{index} - #{key}"
  end
end

# TODO:
def get_events_url
  array = []
  html_doc.search('//a[@href][@hreflang]').each do |link|
    array << link['href']
  end
end

def store_into_csv(event_hash, filepath)
  filepath = filepath + ".csv"
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  header = %w(id date artists details info location title)
  CSV.open(filepath, 'wb', csv_options) do |csv|
    csv << header
    event_hash.each do |key, value|
      array = [key]
      value.each do |k, v|
        array << v
      end
      csv << array
    end
  end
  puts "CSV file ".green + filepath + " created!".green + "\n"
end

# TODO:
def store_into_xml(event_hash, filepath)
  puts "Not implemented yet"
end

def store_into_json(event_hash, filepath)
  filepath = filepath + '.json'
  File.open(filepath, 'w') do |file|
    file.write(JSON.generate(event_hash))
  end
  puts "JSON file ".green + filepath + " created!".green + "\n"
end

def print_choices(event_hash)
  print "(Scraping status: "
  event_hash.empty? ? (puts "Not scraped)".light_red) : (puts "Scraped)".green)
  choices = [
    "Scrape ONBA website (necessary before anything)",
    "Print hash of ONBA events",
    "Store ONBA events into a CSV file",
    "Store ONBA events into a JSON file",
    "Store ONBA events into a xml file",
    "Exit program"
  ]
  choices.each_with_index do |choice, index|
    puts "#{(index + 1).to_s.red} - #{choice}"
  end
end

def please_scrape_first
  puts `clear` + "\n"
  puts "Please scrape first"
  puts "\n"
end

def interface
  event_hash = {}
  loop do
    print `clear`
    puts "What would you like to do?\n\n"
    print_choices(event_hash)
    puts "\n"
    input = 0
    while input <= 0 || input > 6
      input = gets.chomp.to_i
    end
    filepath = Time.now.strftime("ONBA_%Y-%m-%d")
    case input
    when 1
      html_doc = make_html_doc
      event_hash = onba_scraper(html_doc)
      puts "Scraping done!"
    when 2

      event_hash.empty? ? please_scrape_first : print_hash(event_hash)
      gets.chomp
    when 3
      event_hash.empty? ? please_scrape_first : store_into_csv(event_hash, filepath)
      gets.chomp
    when 4
      event_hash.empty? ? please_scrape_first : store_into_json(event_hash, filepath)
      gets.chomp
    when 5
      event_hash.empty? ? please_scrape_first : store_into_xml(event_hash, filepath)
      gets.chomp
    when 6 then exit
    end
  end
end

interface
