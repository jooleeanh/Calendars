require 'colorize'
require_relative '/home/julian/Projects/Calendars/view'

class BordeauxView < View
  def initialize
    @choices = [
      "[ONBA] Opéra National de Bordeaux Aquitaine",
      "[TNBA] Théâtre National de Bordeaux Aquitaine",
      "Exit program"
    ]
  end

  def greeting
    print `clear`
    puts "Welcome to Calendars - [Bordeaux]\n".light_cyan
    puts "Select your organization:\n\n"
  end

  def display_choices
    Dir.chdir(File.dirname(__FILE__))
    directories = Dir.glob('*').select { |f| File.directory? f }
    puts "0".yellow + " - " + "Go back up".light_yellow
    directories.each_with_index do |directory, index|
      puts "#{(index + 1).to_s.red} - #{directory}"
    end
    puts "\n"
  end
end
