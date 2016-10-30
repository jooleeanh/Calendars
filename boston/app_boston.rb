require_relative "router_boston"
require_relative "view_boston"

view = ViewBoston.new

RouterBoston.new(view).run
