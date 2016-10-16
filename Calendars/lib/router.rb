require_relative 'controller'

class Router
  def initialize(event_list, view)
    @view = view
    @controller = Controller.new(event_list, view)
  end

  def run
    loop do
      input = 0
      while input <= 0 || input > 6
        @view.greeting
        @view.print_choices(@controller.event_hash)
        input = gets.chomp.to_i
      end
      dispatch(input)
    end
  end

  private

  def dispatch(input)
    case input
    when 1 then @controller.scrape_onba
    when 2 then @controller.view_hash
    when 3 then @controller.store_csv
    when 4 then @controller.store_json
    when 5 then @controller.store_xml
    when 6 then
      puts "\n"
      exit
    end
  end

end
