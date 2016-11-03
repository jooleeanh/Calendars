require_relative 'controller_boston'
require_relative '../router'

class RouterBoston < Router
  def initialize(view)
    @view = view
    @controller = ControllerBoston.new
    @directories = @controller.get_directories
    @level = "organization"
    begin
      @city = Dir.glob("*.rb").first.scan(/_.*\./)[0].gsub(/_|\./, "").capitalize
    rescue
      @city = nil
    end
  end
end
