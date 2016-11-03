require_relative 'city_controller'
require_relative '../router'

class CityRouter < Router
  def initialize(view)
    @view = view
    @controller = CityController.new
    @directories = @controller.get_directories
    @level = "organization"
    @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize
  end
end
