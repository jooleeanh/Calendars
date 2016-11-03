require_relative "router_parser_ORG"
require_relative "view_parser_ORG"
require "pry-byebug"

class AppParserORG
  def run
    view = ViewParserORG.new
    calendar_url = ""
    event_url_prefix = ""
    RouterParserORG.new(calendar_url, event_url_prefix, view).run
  end
end

AppParserORG.new.run
