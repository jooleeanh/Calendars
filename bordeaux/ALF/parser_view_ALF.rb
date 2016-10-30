require 'colorize'

class ParserViewALF
  def initialize
    @choices = [
      "Scrape ALF website for events' urls (necessary before anything)",
      "Print list of ALF events' urls",
      "Scrape all the events",
      "View all events",
      "Store ALF events into a JSON file",
      "Exit program"
    ]
  end

  def greeting
    print `clear`
    puts "Welcome to Calendars - [Bordeaux] - [ALF] Allez Les Filles\n".light_cyan
    puts "What would you like to do?\n".light_black
  end

  def display_choices(urls_empty_bool, events_empty_bool)
    print "Scraping status: "
    print "(urls - "
    urls_empty_bool ? (print "Not scraped".light_red) : (print "Scraped".green)
    print ") (events - "
    events_empty_bool ? (print "Not scraped".light_red) : (print "Scraped".green)
    puts ")\n\n"
    @choices.each_with_index do |choice, index|
      puts "#{(index + 1).to_s.red} - #{choice}"
    end
    puts "\n"
  end

  def display_hash(hash)
    puts hash
  end

  def display_array(array)
    print `clear`
    puts "ALF events (urls)\n\n"
    array.each_with_index do |link, index|
      puts "#{index}".light_red + " - #{link}"
      sleep(0.01)
    end
  end

  def display_hash_formatted(hash)
    hash.each do |k, v|
      puts "#{k} - #{v}"
    end
  end

  def scraping_done
    puts "\n"
    puts "=" * 50
    puts "\n"
    puts "Scraping done!".green
    puts "\n"
    puts "=" * 50
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def viewing_done
    print "\n Press enter to return to menu> ".light_cyan
    gets.chomp
  end

  def json_done(filepath)
    print `clear`
    puts "JSON file ".green + filepath + ".json created!".green + "\n"
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def scrape_please
    print `clear`
    puts "Please scrape first".light_red
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def begin_parsing(event_url)
    puts "\n"
    puts "=" * 50
    puts "\n"
    puts "Begin parsing #{event_url} ...".light_blue
    puts "\n"
  end

  def parsing_skip(title)
    puts "#{title[0..15]}... - skip: no performers or program notes".light_yellow
  end

  def error_empty_field(title, field)
    puts "#{title[0..15]}... - error: empty '#{field}' field".light_red
  end

  def parsing_success(title, field)
    puts "#{title[0..15]}... - success: #{field}".green
  end

  def scraping_success(link)
    puts "parsing success: #{link}".green
  end
end
