require_relative "city_router"
require_relative "city_view"

view = CityView.new

CityRouter.new(view).run
