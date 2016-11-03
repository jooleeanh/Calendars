require_relative "router_parser_KRA"
require_relative "view_parser_KRA"
require "pry-byebug"

class AppParserKRA
  def run
    view = ViewParserKRA.new
    calendar_url = ""
    # http://www.krakatoa.org/programmation/
    url_domain = ""
    # http://www.krakatoa.org/evenements
    RouterParserKRA.new(calendar_url, url_domain, view).run
  end
end

AppParserKRA.new.run
