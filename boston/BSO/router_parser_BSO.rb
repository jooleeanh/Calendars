require_relative 'controller_parser_BSO'
require_relative '../../.router_parser'

class RouterParserBSO < RouterParser
  def initialize(calendar_url, view)
    @view = view
    @controller = ControllerParserBSO.new(calendar_url, view)
    @city = "boston"
    @org_acronym = "BSO"
    @org_name = "Boston Symphony Orchestra"
  end
end
