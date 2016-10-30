require_relative '../../.router_parser'
require_relative 'controller_parser_ORG'

class RouterParserORG < RouterParser
  def initialize(calendar_url, view) # OVERRIDING
    @view = view
    @controller = ControllerParserORG.new(calendar_url, view)
    @city = "Bordeaux"
    @org_acronym = "ORG"
    @org_name = "ORGkatoa"
  end

  # INHERITING run

  private

  # INHERITING dispatch(input)
end
