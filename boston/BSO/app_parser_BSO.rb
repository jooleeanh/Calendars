require_relative "router_parser_BSO"
require_relative "view_parser_BSO"
require "pry-byebug"

class AppParserBSO
  def run
    view = ViewParserBSO.new
    calendar_url = "https://www.bso.org/Performance/Listing?brands=1182&startDate=9/1/2016%2012:00:00%20AM"
    event_url_prefix = "https://www.bso.org"
    RouterParserBSO.new(calendar_url, event_url_prefix, view).run
  end
end

AppParserBSO.new.run
