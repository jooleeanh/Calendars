require_relative 'controller'
require "pry-byebug"

class Router
  def initialize(view)
    @view = view
    @controller = Controller.new
    @directories = @controller.get_directories
    @level = "city"
    begin
      @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize
    rescue
      @city = nil
    end
  end

  def run
    loop do
      input = -1
      while input < 0 || input > @directories.size
        @view.greeting(@level, @city)
        @view.display_choices(@level, @directories)
        input = gets.chomp.to_i
      end
      dispatch(input)
    end
  end

  private

  def dispatch(input)
    if input == 0
      puts "\n"
      exit
    else
      @controller.go_to(@level, @directories[input - 1])
    end
  end

end
