require_relative "parser_router_BSO"
require_relative "parser_view_BSO"

class ParserAppBSO
  def run
    view = ParserViewBSO.new
    calendar_url = "https://www.bso.org/Performance/Listing?brands=1182&startDate=9/1/2016%2012:00:00%20AM"
    ParserRouterBSO.new(calendar_url, view).run
  end
end

ParserAppBSO.new.run
