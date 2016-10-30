require "pry-byebug"
require_relative '../controller'

class BordeauxController < Controller
  def get_directories
    super(__FILE__)
  end
  def go_to(level, directories)
    super(level, directories, __FILE__)
  end
end
