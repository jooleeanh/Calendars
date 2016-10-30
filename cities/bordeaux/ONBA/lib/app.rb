require_relative "router"
require_relative "event_list"
require_relative "view"


url = url_onba_list
event_list = EventList.new(url)
view = View.new

Router.new(event_list, view).run




def url_onba_list
  domain = "http://www.opera-bordeaux.com/calendar"
  keys = "?keys=&field_date_show_date_value="
  nodes = "&term_node_tid_depth=All&term_node_tid_depth_1=All"
  field = "&field_public_type_target_id=All&field_accessibilite_value=All"
  domain + keys + nodes + field
end
