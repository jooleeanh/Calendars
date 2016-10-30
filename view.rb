require 'colorize'

class View
  def display_choices(level, directories)
    if Dir.pwd.split("/").last == "Calendars"
      puts "0".yellow + " - " + "Exit program".light_yellow
    else
      puts "0".yellow + " - " + "Go back up".light_yellow
    end
    puts "\n"
    directories.each_with_index do |directory, index|
      print "#{(index + 1).to_s.red} - "
      if level == "city"
        puts directory.capitalize
      else
        puts directory.upcase
      end
    end
    puts "\n"
  end

  def greeting(level)
    print `clear`
    print "Welcome to Calendars".light_cyan
    puts " - " + "Main".light_magenta if level == "city"
    puts " - " + level.light_magenta if level == "organization"
    puts "\nSelect your #{level}:\n\n"
  end
end
