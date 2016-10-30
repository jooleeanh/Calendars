require 'colorize'

class BordeauxView
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
    @choices.each_with_index do |choice, index|
      puts "#{(index + 1).to_s.red} - #{choice}"
    end
    puts "\n"
  end
end
