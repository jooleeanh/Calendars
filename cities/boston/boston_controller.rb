require "pry-byebug"
# require_relative 'cities/boston/BSO/parser_app_BSO'
# require_relative 'cities/bordeaux/ONBA/parser_app_BSO'

class BostonController
  def initialize
  end

  def go_to_bso
    path_bso = File.dirname(__FILE__)+'/BSO/parser_app_BSO.rb'
    exec("ruby", path_bso)
  end
end
