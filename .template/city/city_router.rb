require_relative 'city_controller'
require_relative '../router'

class CityRouter < Router
  def initialize(view)
    @view = view
    @controller = CityController.new
    @directories = @controller.get_directories
    @level = "organization"
  end
end
