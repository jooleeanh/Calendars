require_relative 'parser_controller_ALF'

class ParserRouterALF
  def initialize(calendar_url, view)
    @view = view
    @controller = ParserControllerALF.new(calendar_url, view)
  end

  def run
    loop do
      input = 0
      while input <= 0 || input > 6
        @view.greeting
        puts "PARSER INCOMPLETE - PROJECT ABANDONED\n\n"
        @view.display_choices(@controller.events_urls.empty?, @controller.events.empty?)
        input = gets.chomp.to_i
      end
      dispatch(input)
    end
  end

  private

  def dispatch(input)
    case input
    when 1 then @controller.scrape_url_list
    when 2 then @controller.view_url_list
    when 3 then @controller.scrape_all_events
    when 4 then @controller.view_all_events
    when 5 then @controller.store_json
    when 6 then
      puts "\n"
      exit
    end
  end

end
