require_relative '../../.router_parser'
require_relative 'controller_parser_KRA'

class RouterParserKRA < RouterParser
  def initialize(calendar_url, url_domain, view) # OVERRIDING
    @view = view
    @controller = ControllerParserKRA.new(calendar_url, url_domain, view)
    @city = Dir.glob("*.rb").first.scan(/_.*\./)[0]&.gsub(/_|\./, "")&.capitalize || "Testing"
    @org_acronym = self.class.to_s.gsub("RouterParser", "")
    @org_name = LISTING[@org_acronym.to_sym]
  end

  # INHERITING run

  private

  # INHERITING dispatch(input)
end
