require 'colorize'

class View
  def initialize
    @choices = [
      "Boston",
      "Bordeaux",
      "Exit program"
    ]
  end

  def greeting
    print `clear`
    puts "Welcome to Calendars\n".light_cyan
    puts "Select your city:\n\n"
  end

  def display_choices
    @choices.each_with_index do |choice, index|
      puts "#{(index + 1).to_s.red} - #{choice}"
    end
    puts "\n"
  end
end
