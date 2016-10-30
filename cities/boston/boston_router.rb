require_relative 'boston_controller'

class BostonRouter
  def initialize(view)
    @view = view
    @controller = BostonController.new
  end

  def run
    loop do
      input = 0
      while input <= 0 || input > 2
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
    when 1 then @controller.go_to_bso
    when 2 then
      puts "\n"
      exit
    end
  end

end
