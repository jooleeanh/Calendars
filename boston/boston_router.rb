require_relative 'boston_controller'
require_relative '../router'
require "pry-byebug"
class BostonRouter < Router
  def initialize(view)
    @view = view
    @controller = BostonController.new
    @directories = @controller.get_directories
    @level = "organization"
    binding.pry
  end
end
