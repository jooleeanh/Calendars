require 'open-uri'
require 'nokogiri'
require_relative 'event_parser_BSO'
require_relative 'calendar_parser_BSO'
require_relative '../../.controller_parser'

class ControllerParserBSO < ControllerParser

  def initialize(calendar_url, event_url_prefix, view)
    super
    nokodoc = Nokogiri::HTML(open(@calendar_url))
    @calendar = CalendarParserBSO.new(nokodoc, @view, @calendar_url)
  end

  def scrape_all_events
    if @events_urls.empty?
      @view.scrape_please
    else
      @events_urls.each_with_index do |event_url, index|
        event_url = @event_url_prefix + event_url
        nokodoc = Nokogiri::HTML(open(event_url))
        event = EventParserBSO.new(nokodoc, @view, event_url)
        event.parse_all
        @events[index] = event.attributes
      end
      @view.scraping_done
    end
  end

  private

  def create_event_parser # OVERRIDING
    super
    nokodoc = Nokogiri::HTML(open(event_url))
    EventParserORG.new(nokodoc, @view, event_url)
  end
end
