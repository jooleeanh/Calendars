require_relative '.listing'

class RouterParser
  def initialize(calendar_url, event_url_prefix, view)
    @view = view
    @controller = ControllerParser.new(calendar_url, event_url_prefix, view) # to override
    @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize # to override
    @org_acronym = "acronym" # to override
    @org_name = "organization" # to override
  end

  def run
    loop do
      input = -1
      while input < 0 || input > @view.choices.size - 1
        @view.greeting(@city, @org_acronym, @org_name)
        @view.display_choices(@controller.events_urls.empty?, @controller.events.empty?)
        input = gets.chomp.to_i
      end
      dispatch(input)
    end
  end

  private

  def dispatch(input)
    case input
    when 0
      puts "\n"
      exit
    when 1 then @controller.scrape_url_list
    when 2 then @controller.view_url_list
    when 3 then @controller.scrape_all_events
    when 4 then @controller.view_all_events
    when 5 then @controller.store_json(@org_acronym)
    end
  end

end
