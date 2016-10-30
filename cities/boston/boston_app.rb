require_relative "boston_router"
require_relative "boston_view"

view = BostonView.new

BostonRouter.new(view).run
