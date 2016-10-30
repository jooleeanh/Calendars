class ParserCalendarBSO
  attr_reader :events_urls

  def initialize(nokodoc, view, calendar_url)
    @nokodoc = nokodoc
    @view = view
    @calendar_url = calendar_url
    @events_urls = []
  end

  def scrape_links
    @view.begin_parsing(@calendar_url)
    @nokodoc.search("#performance-list").css(".performance:not(.promotion)").each do |event|
      url = event.css(".performance-link > a").attribute("href").text
      @events_urls << url
      @view.scraping_success(url)
      sleep(0.01)
    end
  end

  def store_json(events, filepath)
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(events))
    end
  end
end
