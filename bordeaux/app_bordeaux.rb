require_relative "router_bordeaux"
require_relative "view_bordeaux"

view = ViewBordeaux.new

RouterBordeaux.new(view).run
