require_relative 'bordeaux_controller'
require_relative '../router'

class BordeauxRouter < Router
  def initialize(view)
    @view = view
    @controller = BordeauxController.new
    @directories = @controller.get_directories
    @level = "organization"
  end
end
