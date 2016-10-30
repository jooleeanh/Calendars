require_relative 'bordeaux_controller'

class BordeauxRouter
  def initialize(view)
    @view = view
    @controller = BordeauxController.new
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
    when 1 then @controller.go_to_ONBA
    when 2 then @controller.go_to_TNBA
    when 3 then
      puts "\n"
      exit
    end
  end

end
