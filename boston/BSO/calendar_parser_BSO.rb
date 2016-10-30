require 'json'
require_relative '../../.calendar_parser'

class CalendarParserBSO < CalendarParser
  def scrape_links
    @view.begin_parsing(@calendar_url)
    @nokodoc.search("#performance-list").css(".performance:not(.promotion)").each do |event|
      url = event.css(".performance-link > a").attribute("href").text
      @events_urls << url
      @view.scraping_success(url)
      sleep(0.01)
    end
  end
end
