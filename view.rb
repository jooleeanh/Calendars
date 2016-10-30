require 'colorize'

class View
  def initialize
    @choices = [
      "Boston",
      "Bordeaux",
      "Exit program"
    ]
  end

  def display_choices(directories)
    if Dir.pwd.split("/").last == "Calendars"
      puts "0".yellow + " - " + "Exit program".light_yellow
    else
      puts "0".yellow + " - " + "Go back up".light_yellow
    end
    directories.each_with_index do |directory, index|
      puts "#{(index + 1).to_s.red} - #{directory.capitalize}"
    end
    puts "\n"
  end

  def greeting(choice, levels = {})
    print `clear`
    print "Welcome to Calendars".light_cyan
    levels.each do |k, v|
      print " - " + v.magenta if k == :city
      print " - " + v.light_magenta if k == :organization
    end
    puts "\nSelect your #{choice}:\n\n"
  end
end
