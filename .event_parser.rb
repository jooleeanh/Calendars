class EventParser
  attr_reader :attributes

  def initialize(nokodoc, view, event_url)
    @nokodoc = nokodoc
    @view = view
    @attributes = {}
    @attributes[:url] = event_url
  end
end
