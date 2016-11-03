require_relative 'controller_bordeaux'
require_relative '../router'

class RouterBordeaux < Router
  def initialize(view)
    @view = view
    @controller = ControllerBordeaux.new
    @directories = @controller.get_directories
    @level = "organization"
    begin
      @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize
    rescue
      @city = nil
    end
  end
end
