require_relative '../../.controller_parser'
require 'open-uri'
require 'nokogiri'
require_relative 'event_parser_ORG'
require_relative 'calendar_parser_ORG'

class ControllerParserORG < ControllerParser
  # INHERITING READERS :events_urls, :events

  def initialize(calendar_url, event_url_prefix, view) # OVERRIDING
    super
    begin
      nokodoc = Nokogiri::HTML(open(@calendar_url))
      # super
    rescue
      @view.invalid_url
      @view.viewing_done
    else
      @calendar = CalendarParserORG.new(nokodoc, @view, @calendar_url)
    end
  end

  # INHERITING :
  # - scrape_url_list
  # - view_url_list
  # - scrape_all_events
  # - view_all_events
  # - store_json

  private

  def create_event_parser(event_url) # OVERRIDING
    super
    nokodoc = Nokogiri::HTML(open(event_url))
    EventParserORG.new(nokodoc, @view, event_url)
  end
end
