require_relative 'controller_parser_BSO'
require_relative '../../.router_parser'

class RouterParserBSO < RouterParser
  def initialize(calendar_url, event_url_prefix, view)
    @view = view
    @controller = ControllerParserBSO.new(calendar_url, event_url_prefix, view)
    begin
      @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize
    rescue
      @city = "Testing"
    end
    @org_acronym = self.class.to_s.gsub("RouterParser", "")
    @org_name = LISTING[@org_acronym.to_sym]
  end
end
