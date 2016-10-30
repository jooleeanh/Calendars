require_relative "router"
require_relative "view"

view = View.new

Router.new(view).run
