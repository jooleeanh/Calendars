require 'colorize'

class View
  def initialize
    @choices = [
      "Scrape ONBA website (necessary before anything)",
      "Print hash of ONBA events",
      "Store ONBA events into a CSV file",
      "Store ONBA events into a JSON file",
      "Store ONBA events into a XML file",
      "Exit program"
    ]
  end

  def greeting
    print `clear`
    puts "What would you like to do?\n\n"
  end

  def print_choices(event_hash)
    print "(Scraping status: "
    event_hash.empty? ? (puts "Not scraped)".light_red) : (puts "Scraped)".green)
    @choices.each_with_index do |choice, index|
      puts "#{(index + 1).to_s.red} - #{choice}\n"
    end
    puts "\n"
  end

  def scraping_done
    print `clear`
    puts "Scraping done!".green
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def viewing_done
    print "\n Press enter to return to menu> ".light_cyan
    gets.chomp
  end

  def csv_done(filepath)
    print `clear`
    puts "CSV file ".green + filepath + ".csv created!".green + "\n"
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def json_done(filepath)
    print `clear`
    puts "JSON file ".green + filepath + ".json created!".green + "\n"
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end

  def xml_done(filepath)
    print `clear`
    print "Press enter to return to menu> ".light_cyan
    gets.chomp
  end

  def scrape_please
    print `clear`
    puts "Please scrape first".light_red
    print "\nPress enter to return to menu> ".light_cyan
    gets.chomp
  end
end
