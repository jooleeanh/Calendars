require_relative 'controller'

class Router
  def initialize(view)
    @view = view
    @controller = Controller.new
    @directories = @controller.get_directories
  end

  def run
    loop do
      input = -1
      while input < 0 || input > @directories.size
        @view.greeting("city")
        @view.display_choices(@directories)
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
      @controller.go_to(@directories[input - 1])
    end
  end

end
