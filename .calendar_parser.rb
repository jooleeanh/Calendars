class CalendarParser
  attr_reader :events_urls

  def initialize(nokodoc, view, calendar_url)
    @nokodoc = nokodoc
    @view = view
    @calendar_url = calendar_url
    @events_urls = []
  end

  def store_json(events, filepath)
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(events))
    end
  end
end
