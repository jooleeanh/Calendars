require_relative '../../.router_parser'
require_relative '../../.listing'
require_relative 'controller_parser_ORG'

class RouterParserORG < RouterParser
  def initialize(calendar_url, event_url_prefix, view) # OVERRIDING
    @view = view
    @controller = ControllerParserORG.new(calendar_url, event_url_prefix, view)
    begin
      @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize
    rescue
      @city = "Testing"
    end
    @org_acronym = self.class.to_s.gsub("RouterParser", "")
    @org_name = LISTING[@org_acronym.to_sym]
  end

  # INHERITING run

  private

  # INHERITING dispatch(input)
end
