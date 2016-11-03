require_relative '../../.controller_parser'
require 'open-uri'
require 'nokogiri'
require_relative 'event_parser_KRA'
require_relative 'calendar_parser_KRA'

class ControllerParserKRA < ControllerParser
  # INHERITING READERS :events_urls, :events

  def initialize(calendar_url, url_domain, view) # OVERRIDING
    @view = view
    @calendar_url = calendar_url
    @events_urls = []
    @events = {}
    @url_domain = url_domain
    super
    begin
      nokodoc = Nokogiri::HTML(open(@calendar_url))
    rescue
      @view.invalid_url
      @view.viewing_done
    else
      @calendar = CalendarParserKRA.new(nokodoc, @view, @calendar_url)
    end
  end

  # INHERITING :
  # - scrape_url_list
  # - view_url_list
  # - scrape_all_events
  # - view_all_events
  # - store_json

  private

  def create_event_parser # OVERRIDING
    super
    nokodoc = Nokogiri::HTML(open(event_url))
    EventParserKRA.new(nokodoc, @view, event_url)
  end
end
