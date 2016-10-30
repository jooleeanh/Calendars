require_relative "bordeaux_router"
require_relative "bordeaux_view"

view = BordeauxView.new

BordeauxRouter.new(view).run
