require 'json'

class ParserCalendarALF
  attr_reader :events_urls

  def initialize(nokodoc, view, calendar_url)
    @nokodoc = nokodoc
    @view = view
    @calendar_url = calendar_url
    @events_urls = []
  end

  def scrape_links
    @view.begin_parsing(@calendar_url)
    @nokodoc.search("#mod_5090842 > .cel1safe").each do |row|
      begin
        url = row.css(".pave_left").css(".titre_article > a").attribute("href").text
      rescue
        @view.error_empty_field("div", "href")
      else
        @events_urls << url
        @view.scraping_success(url)
        sleep(0.01)
      end

      begin
        url = row.css(".pave_right").css(".titre_article > a").attribute("href").text
      rescue
        @view.error_empty_field("div", "href")
      else
        @events_urls << url
        @view.scraping_success(url)
        sleep(0.01)
      end
    end
  end

  def store_json(events, filepath)
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(events))
    end
  end
end
