require_relative '../../.event_parser'

class EventParserKRA < EventParser
  # INHERITING READERS :attributes

  def initialize(nokodoc, view, event_url) # INHERITING/OVERRIDING
    super
    @nokodoc = @nokodoc # refine css search
  end

  def parse_all # NEW DEFINITION
    @view.begin_parsing(@attributes[:url])
    # TODO: write scraping code
    parse_date
    parse_title
    
  end

  private

end
