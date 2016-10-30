require 'open-uri'
require 'nokogiri'
require_relative 'parser_event_ALF'
require_relative 'parser_calendar_ALF'

class ParserControllerALF
  attr_reader :events_urls, :events

  def initialize(calendar_url, view)
    @view = view
    @calendar_url = calendar_url
    @events_urls = []
    @events = {}
    nokodoc = Nokogiri::HTML(open(@calendar_url))
    @calendar = ParserCalendarALF.new(nokodoc, @view, @calendar_url)
  end

  def scrape_url_list
    @calendar.scrape_links
    @events_urls = @calendar.events_urls
    @view.scraping_done
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
        event_url = "http://www.allezlesfilles.net" + event_url
        nokodoc = Nokogiri::HTML(open(event_url))
        event = ParserEventALF.new(nokodoc, @view, event_url)
        event.parse_all
        @events[index] = event.attributes
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
    filepath = Time.now.strftime('files/ALF_%Y-%m-%d-%H-%M')
    if @events.empty?
      @view.scrape_please
    else
      @calendar.store_json(@events, filepath)
      @view.json_done(filepath)
    end
  end
end
