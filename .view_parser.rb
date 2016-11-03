require_relative '.listing'

class ViewParser
  attr_reader :choices

  def initialize
    @choices = [
      "Exit parser\n".light_yellow,
      "Scrape website for events' urls (necessary before anything)",
      "Print list of events' urls",
      "Scrape all the events",
      "View all events",
      "Store events into a JSON file",
    ]
  end

  def invalid_url
    puts "\nError: invalid url".light_red
  end

  def greeting(city, org_acronym, org_name)
    print `clear`
    print LISTING[:app].light_cyan
    print " - " + city.blue
    print " - [" + org_acronym.light_blue + "] "
    puts org_name.light_blue
    print "\n"
  end

  def display_choices(urls_empty_bool, events_empty_bool)
    puts "Scraping status: "
    if urls_empty_bool
      (puts "[ ] " + "Calendar (event urls)".light_red)
    else
      (puts "[X] " + "Calendar (event urls)".green)
    end
    if events_empty_bool
      (puts "[ ] " + "Events (data)".light_red)
    else
      (puts "[X] " + "Events (data)".green)
    end
    puts "\n"
    puts "What would you like to do?\n".light_white
    @choices.each_with_index do |choice, index|
      puts "#{index.to_s.red} - #{choice}"
    end
    puts "\n"
  end

  def display_hash(hash)
    puts hash
  end

  def display_array(array)
    print `clear`
    puts " events (urls)\n\n"
    array.each_with_index do |link, index|
      puts "#{index}".light_red + " - #{link}"
      sleep(0.01)
    end
    puts "\nTotal - #{array.length}".light_yellow
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
    viewing_done
  end

  def viewing_done
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def json_done(filepath)
    print "\n"
    puts "JSON file ".green + filepath + ".json created!".green + "\n"
    viewing_done
  end

  def scrape_please
    print "\n"
    puts "Please scrape first".light_red
    viewing_done
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
