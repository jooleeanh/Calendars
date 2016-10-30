require 'colorize'
require_relative '../view'

class BostonView < View
  def initialize
    @choices = [
      "[BSO] Boston Symphony Orchestra",
      "Exit program"
    ]
  end
end
