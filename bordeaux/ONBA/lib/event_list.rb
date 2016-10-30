require 'open-uri'
require 'nokogiri'
require 'csv'
require 'json'
require 'colorize'
require 'unicode_utils'

class EventList
  def initialize(url)
    @html_doc = make_html_doc(url)
    @month = %w(index0 janvier février mars avril mai juin juillet août septembre octobre novembre décembre)
    @upcase = ["ONBA"]
    @downcase = ["L", "D", "M", "T", "S", "N"]
  end

  def make_html_doc(url)
    html_file = open(url)
    Nokogiri::HTML(html_file)
  end

  def onba_scraper
    event_hash = {}
    @html_doc.search('.calendar-result').search('.row').each_with_index do |row, index|
      attributes = {}
      date = get_date(row)
      row.each do |_|
        attributes[:date] = make_date(date, get_time(row))
        attributes[:title] = get_title(row, get_metadata(row))
        attributes = attributes.merge(get_metadata(row))
        invalid_entry = (attributes[:date] == nil)
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

  def store_into_csv(event_hash, filepath)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    header = %w(id date artists details info location title)
    CSV.open(filepath + '.csv', 'wb', csv_options) do |csv|
      csv << header
      event_hash.each do |key, value|
        array = [key]
        value.each do |k, v|
          array << v
        end
        csv << array
      end
    end
  end

  def store_into_json(event_hash, filepath)
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(event_hash))
    end
  end

  # TODO:
  def store_into_xml(event_hash, filepath)
    puts "\nNot implemented yet"
  end

  private

  def get_date(row)
    # date-day
    day = row.search('.show-date-day').text.to_i
    # date-month
    month = row.search('.show-date-month').text
    month = @month.index(month)
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
    hash = {}
    time = row.search('.show-place-time').text
    hash[:location] = row.search('.tag-inverse').text.gsub(time, "").gsub(/\\.|\s{2,}/, "")
    hash[:artists] = row.search('.show-author').text
    hash[:info] = row.search('.date-show-info').text.strip.gsub(/\s#.{7}/, "")
    hash[:details] = row.search('.show-more').text.strip
    hash
  end

  def get_title(row, attributes)
    title = row.search('.col-md-8').text
    title = title.gsub(attributes[:artists], "").gsub(attributes[:details], "")
    title = title.gsub(attributes[:info], "").gsub(/\s#.{7}/, "")
    title = title.tr('+', '').strip
    UnicodeUtils.upcase(title).split(/\b/).map do |x|
      if @downcase.include?(x)
        x.downcase
      elsif @upcase.include?(x)
        x
      else
        (x[0] + UnicodeUtils.downcase(x[1..-1]))
      end
    end.join("")
  end
end
