require "pry-byebug"
# require_relative 'cities/boston/BSO/parser_app_BSO'
# require_relative 'cities/bordeaux/ONBA/parser_app_BSO'

class BordeauxController
  def initialize
  end

  def go_to_ONBA
    path_ONBA = File.dirname(__FILE__)+'/ONBA/parser_app_ONBA.rb'
    exec("ruby", path_ONBA)
  end
end
