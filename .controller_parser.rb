class ControllerParser
  attr_reader :events_urls, :events

  def initialize(calendar_url, view)
    @view = view
    @calendar_url = calendar_url
    @events_urls = []
    @events = {}
  end

  def scrape_url_list
    begin
      @calendar.scrape_links
    rescue
      @view.invalid_url
      @view.viewing_done
    else
      @events_urls = @calendar.events_urls
      @view.scraping_done
    end
  end

  def view_url_list
    if @events_urls.empty?
      @view.scrape_please
    else
      @view.display_array(@events_urls)
      @view.viewing_done
    end
  end

  def scrape_all_events
    if @events_urls.empty?
      @view.scrape_please
    else
      @events_urls.each_with_index do |event_url, index|
        event_url = @url_domain + event_url
        event = create_event_parser(event_url)
        event.parse_all
        @events[index + 1] = event.attributes
      end
      @view.scraping_done
    end
  end

  def view_all_events
    if @events.empty?
      @view.scrape_please
    else
      @view.display_hash(@events)
      @view.viewing_done
    end
  end

  def store_json
    filepath = Time.now.strftime('files/_%Y-%m-%d-%H-%M')
    if @events.empty?
      @view.scrape_please
    else
      @calendar.store_json(@events, filepath)
      @view.json_done(filepath)
    end
  end

  private

  def create_event_parser(event_url)
    begin
      Nokogiri::HTML(open(event_url))
    rescue
      @view.invalid_url
      @view.viewing_done
    end
  end
end
