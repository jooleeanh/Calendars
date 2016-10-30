require 'colorize'

class View
  def display_choices(directories)
    if Dir.pwd.split("/").last == "Calendars"
      puts "0".yellow + " - " + "Exit program".light_yellow
    else
      puts "0".yellow + " - " + "Go back up".light_yellow
    end
    directories.each_with_index do |directory, index|
      puts "#{(index + 1).to_s.red} - #{directory}"
    end
    puts "\n"
  end

  def greeting(level)
    print `clear`
    print "Welcome to Calendars".light_cyan
    print " - " + level.magenta if level == "city"
    print " - " + level.light_magenta if level == "organization"
    puts "\nSelect your #{level}:\n\n"
  end
end
