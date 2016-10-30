require_relative 'controller'

class Router
  def initialize(view)
    @view = view
    @controller = Controller.new
  end

  def run
    loop do
      input = 0
      while input <= 0 || input > 3
        @view.greeting
        @view.display_choices
        input = gets.chomp.to_i
      end
      dispatch(input)
    end
  end

  private

  def dispatch(input)
    case input
    when 1 then @controller.go_to_boston
    when 2 then @controller.go_to_bordeaux
    when 3 then
      puts "\n"
      exit
    end
  end

end
