require_relative '../../.calendar_parser'
require 'json'

class CalendarParserKRA < CalendarParser
  # INHERITING initialize(nokodoc, view, calendar_url)

  def scrape_links # NEW DEFINITION
    @view.begin_parsing(@calendar_url)
    @nokodoc.search(".lien-article").each do |event|
      url = event.attribute("href").text
      @events_urls << url
      @view.scraping_success(url)
      sleep(0.01)
    end
  end

  # INHERITING store_json(events, filepath)
end
