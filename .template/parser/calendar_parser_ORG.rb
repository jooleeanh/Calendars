require_relative '../../.calendar_parser'
require 'json'

class CalendarParserORG < CalendarParser
  # INHERITING initialize(nokodoc, view, calendar_url)

  def scrape_links # NEW DEFINITION
    @view.begin_parsing(@calendar_url)
    # @nokodoc.search("LINK CSS").each do |event|
    #   url = event.css("LINK CSS")
    #   @events_urls << url
      @view.scraping_success(url)
      sleep(0.01)
    # end
  end

  # INHERITING store_json(events, filepath)
end
