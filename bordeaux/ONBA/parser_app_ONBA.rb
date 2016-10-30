require_relative "parser_router_ONBA"
require_relative "parser_calendar_ONBA"
require_relative "parser_view_ONBA"

def url_onba_list
  domain = "http://www.opera-bordeaux.com/calendar"
  keys = "?keys=&field_date_show_date_value="
  nodes = "&term_node_tid_depth=All&term_node_tid_depth_1=All"
  field = "&field_public_type_target_id=All&field_accessibilite_value=All"
  domain + keys + nodes + field
end

url = url_onba_list
calendar = ParserCalendarONBA.new(url)
view = ParserViewONBA.new

ParserRouterONBA.new(calendar, view).run
